extends SceneTree
const Sim = preload("res://scripts/match.gd")
const Wire = preload("res://scripts/wire.gd")
const MAX_ROOMS := 20
const MAX_CONNECTIONS := 128
const RECONNECT_MS := 20000
const ROOM_TTL_MS := 1800000
var listener := TCPServer.new()
var peers: Dictionary = {}
var rooms: Dictionary = {}
var sequence := 0
var crypto := Crypto.new()
var accumulator := 0.0
var state_clock := 0.0
var maintenance_clock := 0.0
var match_duration := 180.0

func _initialize() -> void:
	Engine.max_fps = 60
	var port := int(OS.get_environment("PORT")) if OS.has_environment("PORT") else 8787
	if OS.has_environment("NAADAN_MATCH_SECONDS"): match_duration = clampf(float(OS.get_environment("NAADAN_MATCH_SECONDS")), 5, 600)
	var error := listener.listen(port, "0.0.0.0")
	if error != OK:
		push_error("Cannot bind room server: %d" % error)
		quit(1)
	else: print("ROOM_SERVER_READY port=", port)

func _process(dt: float) -> bool:
	var now := Time.get_ticks_msec()
	while listener.is_connection_available():
		var tcp := listener.take_connection()
		if peers.size() >= MAX_CONNECTIONS:
			tcp.disconnect_from_host()
			continue
		var ws := WebSocketPeer.new()
		ws.inbound_buffer_size = 16384
		ws.outbound_buffer_size = 262144
		ws.max_queued_packets = 128
		if ws.accept_stream(tcp) != OK: continue
		sequence += 1
		peers[sequence] = {"ws": ws, "since": now, "last": now, "window": now, "count": 0, "room": "", "pid": 0}
	for cid in peers.keys():
		if not peers.has(cid): continue
		var peer: Dictionary = peers[cid]
		var ws: WebSocketPeer = peer.ws
		ws.poll()
		var state := ws.get_ready_state()
		if state == WebSocketPeer.STATE_CLOSED or now - peer.last > 45000 or (state == WebSocketPeer.STATE_CONNECTING and now - peer.since > 10000):
			disconnect_peer(cid)
			continue
		if state != WebSocketPeer.STATE_OPEN: continue
		var processed := 0
		while ws.get_available_packet_count() > 0 and processed < 64:
			processed += 1
			var packet := ws.get_packet()
			if packet.size() > 4096:
				ws.close(1009, "Message too large")
				break
			if now - peer.window > 1000:
				peer.window = now
				peer.count = 0
			peer.count += 1
			if peer.count > 90:
				ws.close(1008, "Rate limit")
				break
			peer.last = now
			var message = JSON.parse_string(packet.get_string_from_utf8())
			if not message is Dictionary: continue
			handle(cid, message)
	accumulator = minf(accumulator + dt, 0.1)
	while accumulator >= 1.0 / 60:
		accumulator -= 1.0 / 60
		for code in rooms:
			var room: Dictionary = rooms[code]
			if room.phase != "playing": continue
			room.sim.step(1.0 / 60)
			if room.sim.time_left <= 0:
				room.phase = "results"
				for pid in room.players: room.players[pid].ready = false
				broadcast_state(room)
				broadcast_lobby(room)
				print("ROUND_FINISHED room=", code, " round=", room.round)
	state_clock += dt
	if state_clock >= 0.05:
		state_clock = 0
		for code in rooms:
			var room: Dictionary = rooms[code]
			if room.phase == "playing": broadcast_state(room)
			room.sim.events.clear()
	maintenance_clock += dt
	if maintenance_clock > 1:
		maintenance_clock = 0
		maintain(now)
	return false

func send(cid: int, message: Dictionary) -> void:
	if not peers.has(cid): return
	var ws: WebSocketPeer = peers[cid].ws
	if ws.get_ready_state() != WebSocketPeer.STATE_OPEN: return
	if ws.get_current_outbound_buffered_amount() > 131072:
		ws.close(1013, "Slow connection")
		return
	ws.send_text(JSON.stringify(message))

func fail(cid: int, message: String) -> void:
	send(cid, {"type": "error", "message": message})

func handle(cid: int, message: Dictionary) -> void:
	var peer: Dictionary = peers[cid]
	var kind = message.get("type", "")
	if not kind is String: return
	if kind == "ping":
		send(cid, {"type": "pong"})
		return
	if peer.room.is_empty():
		if kind == "create" or kind == "join":
			var title = message.get("name", "Player")
			if not title is String or title.length() > 40:
				fail(cid, "Invalid player name")
				return
			title = title.strip_edges().replace("\n", " ").replace("\r", " ").left(18)
			if title.is_empty(): title = "Player"
			var code := ""
			if kind == "create":
				if rooms.size() >= MAX_ROOMS:
					fail(cid, "Server full. Try again later.")
					return
				code = crypto.generate_random_bytes(3).hex_encode().to_upper()
				while rooms.has(code): code = crypto.generate_random_bytes(3).hex_encode().to_upper()
				rooms[code] = {"code": code, "players": {}, "next_id": 0, "host": 1, "phase": "lobby", "round": 0, "sim": Sim.new(), "created": Time.get_ticks_msec()}
			else:
				var raw = message.get("code", "")
				if not raw is String: return
				code = raw.strip_edges().to_upper()
				if not rooms.has(code):
					fail(cid, "Room not found. Check the six-character code.")
					return
			var skin = message.get("skin", 0)
			var gun = message.get("gun", 0)
			if not (skin is float or skin is int) or not (gun is float or gun is int): return
			var room: Dictionary = rooms[code]
			if room.players.size() >= Sim.MAX_PLAYERS:
				fail(cid, "Room is full (six players).")
				return
			room.next_id += 1
			var pid: int = room.next_id
			room.players[pid] = {"id": pid, "name": title, "skin": clampi(int(skin), 0, 5), "gun": clampi(int(gun), 0, 2), "token": crypto.generate_random_bytes(24).hex_encode(), "cid": cid, "ready": false, "until": 0}
			peer.room = code
			peer.pid = pid
			room.sim.add_actor(pid, title)
			room.sim.customize(pid, int(skin), int(gun))
			welcome(cid, room, pid)
			broadcast_lobby(room)
			if kind == "create": print("ROOM_CREATED code=", code)
		elif kind == "resume":
			var code = message.get("code", "")
			var token = message.get("token", "")
			if not code is String or not token is String or not rooms.has(code):
				fail(cid, "Room expired. Create or join a new room.")
				return
			var room: Dictionary = rooms[code]
			for pid in room.players:
				var player: Dictionary = room.players[pid]
				if player.token == token and token.length() == 48:
					if player.cid != -1:
						fail(cid, "This player is already connected.")
						return
					if player.until < Time.get_ticks_msec(): break
					player.cid = cid
					player.until = 0
					peer.room = code
					peer.pid = pid
					welcome(cid, room, pid)
					broadcast_lobby(room)
					print("PLAYER_RESUMED room=", code, " id=", pid)
					return
			fail(cid, "Reconnect expired. Join again.")
		return
	if not rooms.has(peer.room): return
	var room: Dictionary = rooms[peer.room]
	var pid: int = peer.pid
	if kind == "leave":
		remove_player(room, pid)
		peer.room = ""
		peer.pid = 0
	elif kind == "ready" and room.phase != "playing":
		room.players[pid].ready = message.get("ready", false) == true
		broadcast_lobby(room)
	elif kind == "start":
		if pid != room.host or room.phase == "playing": return
		if room.players.size() < 2:
			fail(cid, "At least two players are needed.")
			return
		for player in room.players.values():
			if not player.ready or player.cid == -1:
				fail(cid, "Wait until everyone is connected and ready.")
				return
		room.sim = Sim.new()
		room.sim.time_left = match_duration
		for player in room.players.values():
			room.sim.add_actor(player.id, player.name)
			room.sim.customize(player.id, player.skin, player.gun)
		room.phase = "playing"
		room.round += 1
		broadcast_lobby(room)
		broadcast_state(room)
		print("ROUND_STARTED room=", room.code, " round=", room.round)
	elif kind == "input" and room.phase == "playing":
		var aim = message.get("aim", [])
		var move = message.get("move", 0)
		var weapon = message.get("weapon", 0)
		if not aim is Array or aim.size() != 2 or not (move is float or move is int) or not (weapon is float or weapon is int): return
		room.sim.set_input(pid, {"move": move, "aim": Wire.vector(aim), "weapon": int(weapon), "fly": message.get("fly", false) == true, "fire": message.get("fire", false) == true, "reload": message.get("reload", false) == true})

func welcome(cid: int, room: Dictionary, pid: int) -> void:
	send(cid, {"type": "joined", "code": room.code, "id": pid, "token": room.players[pid].token})

func broadcast_lobby(room: Dictionary) -> void:
	var members: Array = []
	for player in room.players.values():
		var a: Dictionary = room.sim.actors.get(player.id, {})
		members.append({"id": player.id, "name": player.name, "ready": player.ready, "connected": player.cid != -1, "kills": a.get("kills", 0), "deaths": a.get("deaths", 0)})
	for player in room.players.values(): send(player.cid, {"type": "lobby", "code": room.code, "host": room.host, "phase": room.phase, "round": room.round, "players": members})

func broadcast_state(room: Dictionary) -> void:
	var state := Wire.pack_state(room.sim.snapshot())
	state.round = room.round
	for player in room.players.values(): send(player.cid, state)

func disconnect_peer(cid: int) -> void:
	if not peers.has(cid): return
	var peer: Dictionary = peers[cid]
	if rooms.has(peer.room):
		var room: Dictionary = rooms[peer.room]
		if room.players.has(peer.pid) and room.players[peer.pid].cid == cid:
			room.players[peer.pid].cid = -1
			room.players[peer.pid].ready = false
			room.players[peer.pid].until = Time.get_ticks_msec() + RECONNECT_MS
			if room.sim.actors.has(peer.pid): room.sim.actors[peer.pid].input = {}
			broadcast_lobby(room)
	peer.ws.close()
	peers.erase(cid)

func remove_player(room: Dictionary, pid: int) -> void:
	room.players.erase(pid)
	room.sim.actors.erase(pid)
	if room.players.is_empty():
		rooms.erase(room.code)
		return
	if room.host == pid: room.host = room.players.keys()[0]
	broadcast_lobby(room)

func maintain(now: int) -> void:
	for code in rooms.keys():
		if not rooms.has(code): continue
		var room: Dictionary = rooms[code]
		if now - room.created > ROOM_TTL_MS:
			for player in room.players.values():
				send(player.cid, {"type": "error", "fatal": true, "message": "Room expired after 30 minutes. Create a fresh room."})
				if peers.has(player.cid): peers[player.cid].ws.close(1000, "Room expired")
			rooms.erase(code)
			continue
		for pid in room.players.keys():
			var p: Dictionary = room.players[pid]
			if p.cid == -1 and now > p.until: remove_player(room, pid)
