extends RefCounted

static func vector(value) -> Vector2:
	if value is Array and value.size() == 2 and (value[0] is float or value[0] is int) and (value[1] is float or value[1] is int):
		return Vector2(float(value[0]), float(value[1]))
	return Vector2.ZERO

static func pack_state(state: Dictionary) -> Dictionary:
	var result := {"type": "state", "time": state.time, "tick": state.tick, "actors": [], "bullets": [], "events": []}
	for id in state.actors:
		var a: Dictionary = state.actors[id].duplicate()
		for key in ["p", "v", "aim"]: a[key] = [a[key].x, a[key].y]
		result.actors.append(a)
	for b in state.bullets: result.bullets.append({"p": [b.p.x, b.p.y], "v": [b.v.x, b.v.y]})
	for e in state.events:
		var copy: Dictionary = e.duplicate()
		copy.p = [e.p.x, e.p.y]
		result.events.append(copy)
	return result

static func unpack_state(state: Dictionary) -> Dictionary:
	var result := {"actors": {}, "bullets": [], "events": [], "time": float(state.get("time", 180)), "tick": int(state.get("tick", 0))}
	for a in state.get("actors", []):
		for key in ["p", "v", "aim"]: a[key] = vector(a[key])
		for key in ["id", "hp", "kills", "deaths", "weapon", "ammo"]: a[key] = int(a[key])
		result.actors[a.id] = a
	for b in state.get("bullets", []): result.bullets.append({"p": vector(b.p), "v": vector(b.v)})
	for e in state.get("events", []):
		e.p = vector(e.p)
		e.actor = int(e.actor)
		if e.has("by"): e.by = int(e.by)
		result.events.append(e)
	return result

static func pack_input(data: Dictionary) -> Dictionary:
	return {"type": "input", "move": data.move, "aim": [data.aim.x, data.aim.y], "fly": data.fly, "fire": data.fire, "reload": data.reload, "weapon": data.weapon}
