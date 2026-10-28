extends RefCounted
const WORLD := Vector2(2560, 1440)
const MAX_PLAYERS := 6
const WEAPONS := [
	{"name": "MONSOON / SMG", "rate": 0.115, "damage": 15, "speed": 1550.0, "ammo": 32, "spread": 0.045, "pellets": 1},
	{"name": "THUNDER / SHOTGUN", "rate": 0.72, "damage": 13, "speed": 1250.0, "ammo": 8, "spread": 0.17, "pellets": 6},
	{"name": "HARBOUR / RIFLE", "rate": 0.42, "damage": 38, "speed": 2100.0, "ammo": 12, "spread": 0.012, "pellets": 1}
]
var platforms: Array[Rect2] = [Rect2(0, 1350, 2560, 90), Rect2(100, 1100, 470, 35), Rect2(750, 1100, 330, 35), Rect2(1250, 1100, 430, 35), Rect2(1870, 1100, 500, 35), Rect2(370, 820, 420, 35), Rect2(1000, 800, 570, 35), Rect2(1830, 800, 390, 35), Rect2(100, 520, 340, 35), Rect2(680, 510, 430, 35), Rect2(1370, 480, 400, 35), Rect2(2020, 490, 420, 35)]
var actors: Dictionary = {}
var bullets: Array[Dictionary] = []
var events: Array[Dictionary] = []
var time_left := 180.0
var tick := 0
var next_bullet := 0
var spawns: Array[Vector2] = [Vector2(210, 1030), Vector2(2120, 730), Vector2(1250, 730), Vector2(800, 450), Vector2(1520, 410), Vector2(2200, 430)]

func add_actor(id: int, title: String, bot: bool = false) -> void:
	if actors.size() >= MAX_PLAYERS or actors.has(id): return
	actors[id] = {"id": id, "skin": absi(id) % 6, "title": title.left(18), "bot": bot, "p": spawns[actors.size() % spawns.size()], "v": Vector2.ZERO, "aim": Vector2.RIGHT, "hp": 100, "fuel": 100.0, "kills": 0, "deaths": 0, "weapon": 0, "ammo": 32, "cool": 0.0, "reload": 0.0, "dead": 0.0, "shield": 2.0, "input": {}, "input_age": 0.0, "flash": 0.0, "fly": false}

func customize(id: int, skin: int, gun: int) -> void:
	if not actors.has(id): return
	actors[id].skin = clampi(skin, 0, 5)
	actors[id].weapon = clampi(gun, 0, 2)
	actors[id].ammo = WEAPONS[actors[id].weapon].ammo

func set_input(id: int, data: Dictionary) -> void:
	if not actors.has(id): return
	var move_value = data.get("move", 0.0)
	var aim_value = data.get("aim", Vector2.RIGHT)
	var weapon_value = data.get("weapon", 0)
	if not (move_value is float or move_value is int) or not aim_value is Vector2 or not weapon_value is int: return
	if not is_finite(float(move_value)) or not aim_value.is_finite(): return
	actors[id].input_age = 0.0
	actors[id].input = {"move": clampf(float(move_value), -1, 1), "aim": aim_value.normalized(), "fly": data.get("fly", false) == true, "fire": data.get("fire", false) == true, "reload": data.get("reload", false) == true, "weapon": clampi(weapon_value, 0, 2)}

func step(dt: float) -> void:
	if time_left <= 0: return
	time_left = maxf(0, time_left - dt)
	tick += 1
	for id in actors:
		var a: Dictionary = actors[id]
		if a.dead > 0:
			a.dead -= dt
			if a.dead <= 0:
				a.p = spawns[randi() % spawns.size()]
				a.v = Vector2.ZERO
				a.hp = 100
				a.fuel = 100.0
				a.ammo = WEAPONS[a.weapon].ammo
				a.shield = 2.0
				a.reload = 0.0
			continue
		if a.bot: set_input(id, bot_input(a))
		a.input_age += dt
		if a.input_age > 0.35: a.input = {}
		var intent: Dictionary = a.input
		a.cool = maxf(0, a.cool - dt)
		a.flash = maxf(0, a.flash - dt)
		a.shield = maxf(0, a.shield - dt)
		if a.reload > 0:
			a.reload = maxf(0, a.reload - dt)
			if a.reload <= 0: a.ammo = WEAPONS[a.weapon].ammo
		var chosen: int = intent.get("weapon", a.weapon)
		if chosen != a.weapon:
			a.weapon = chosen
			a.ammo = WEAPONS[chosen].ammo
			a.reload = 1.1
		a.aim = intent.get("aim", a.aim)
		a.v.x = move_toward(a.v.x, float(intent.get("move", 0.0)) * 370, 2300 * dt)
		a.v.y = minf(800, a.v.y + 1000 * dt)
		a.fly = intent.get("fly", false) and a.fuel > 0
		if a.fly:
			a.v.y = maxf(-430, a.v.y - 2150 * dt)
			a.fuel = maxf(0, a.fuel - 29 * dt)
		else: a.fuel = minf(100, a.fuel + 22 * dt)
		var old: Vector2 = a.p
		a.p += a.v * dt
		a.p.x = clampf(a.p.x, 24, WORLD.x - 24)
		if a.p.y < 30:
			a.p.y = 30
			a.v.y = maxf(0, a.v.y)
		for platform in platforms:
			if a.v.y >= 0 and old.y + 27 <= platform.position.y and a.p.y + 27 >= platform.position.y and a.p.x > platform.position.x - 12 and a.p.x < platform.end.x + 12:
				a.p.y = platform.position.y - 27
				a.v.y = 0
		if intent.get("reload", false) or a.ammo == 0:
			if a.reload <= 0 and a.ammo < WEAPONS[a.weapon].ammo: a.reload = 1.25
		if intent.get("fire", false) and a.cool <= 0 and a.reload <= 0 and a.ammo > 0: fire(a)
	for i in range(bullets.size() - 1, -1, -1):
		var b: Dictionary = bullets[i]
		var old: Vector2 = b.p
		var end: Vector2 = old + b.v * dt
		var distance := old.distance_to(end)
		var victim := 0
		var hit_position := end
		var collision := false
		for platform in platforms:
			var t := segment_box(old, end, platform)
			if t >= 0 and t * old.distance_to(end) <= distance:
				distance = t * old.distance_to(end)
				hit_position = old.lerp(end, t)
				collision = true
		for id in actors:
			var target: Dictionary = actors[id]
			if id == b.owner or target.dead > 0 or target.shield > 0: continue
			var t := segment_box(old, end, Rect2(target.p - Vector2(21, 58), Vector2(42, 85)))
			if t >= 0 and t * old.distance_to(end) < distance:
				distance = t * old.distance_to(end)
				hit_position = old.lerp(end, t)
				victim = id
				collision = true
		b.p = hit_position
		b.ttl -= dt
		if collision:
			events.append({"kind": "hit", "p": hit_position, "actor": victim})
			if victim != 0: damage(victim, b.owner, b.damage)
		if collision or b.ttl <= 0: bullets.remove_at(i)
	if events.size() > 80: events = events.slice(-80)

func fire(a: Dictionary) -> void:
	var w: Dictionary = WEAPONS[a.weapon]
	a.cool = w.rate
	a.ammo -= 1
	a.flash = 0.06
	a.shield = 0.0
	for pellet in range(w.pellets):
		var direction: Vector2 = a.aim.rotated(randf_range(-w.spread, w.spread))
		next_bullet += 1
		bullets.append({"id": next_bullet, "owner": a.id, "p": a.p - Vector2(0, 18) + a.aim * 12, "v": direction * w.speed, "ttl": 0.85 if a.weapon == 1 else 1.3, "damage": w.damage})
	events.append({"kind": "shot", "p": a.p, "actor": a.id})

func damage(victim: int, attacker: int, amount: int) -> void:
	var a: Dictionary = actors[victim]
	a.hp = maxi(0, a.hp - amount)
	if a.hp == 0:
		a.dead = 2.5
		a.deaths += 1
		if actors.has(attacker): actors[attacker].kills += 1
		events.append({"kind": "down", "p": a.p, "actor": victim, "by": attacker})

func bot_input(a: Dictionary) -> Dictionary:
	var closest: Dictionary = {}
	var nearest := INF
	for id in actors:
		var other: Dictionary = actors[id]
		if id == a.id or other.dead > 0: continue
		var d: float = a.p.distance_squared_to(other.p)
		if d < nearest:
			nearest = d
			closest = other
	if closest.is_empty(): return {}
	var diff: Vector2 = closest.p - a.p
	var direction := diff.normalized().rotated(sin(float(tick) * 0.027 + a.id) * 0.12)
	return {"move": signf(diff.x) if absf(diff.x) > 270 else sin(float(tick) * 0.025 + a.id), "aim": direction, "fly": (diff.y < -70 or a.p.y > 1200 or sin(float(tick) * 0.019 + a.id) > 0.8) and a.fuel > 15, "fire": nearest < 1100000 and tick % 100 > 20, "weapon": a.weapon}

static func segment_box(start: Vector2, end: Vector2, box: Rect2) -> float:
	var delta := end - start
	var low := 0.0
	var high := 1.0
	for axis in range(2):
		if absf(delta[axis]) < 0.00001:
			if start[axis] < box.position[axis] or start[axis] > box.end[axis]: return -1.0
		else:
			var first: float = (box.position[axis] - start[axis]) / delta[axis]
			var second: float = (box.end[axis] - start[axis]) / delta[axis]
			if first > second:
				var swap := first
				first = second
				second = swap
			low = maxf(low, first)
			high = minf(high, second)
			if low > high: return -1.0
	return low

func snapshot() -> Dictionary:
	var visible: Dictionary = {}
	for id in actors:
		var a: Dictionary = actors[id].duplicate()
		for key in ["input", "input_age", "cool", "bot"]: a.erase(key)
		visible[id] = a
	var visible_bullets: Array = []
	for bullet in bullets:
		visible_bullets.append({"p": bullet.p, "v": bullet.v})
	return {"actors": visible, "bullets": visible_bullets, "time": time_left, "tick": tick, "events": events.duplicate(true)}
