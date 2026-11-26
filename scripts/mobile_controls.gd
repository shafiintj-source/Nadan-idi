extends Control
## Touch HUD: left thumb moves; right thumb aims; action buttons stay at screen edges.

var _move_touch := -1
var _look_touch := -1
var _fire_touch := -1
var _jump_touch := -1
var _reload_touch := -1
var _sprint_touch := -1
var _switch_touch := -1
var _move_vector := Vector2.ZERO
var _look_delta := Vector2.ZERO
var _jump_requested := false
var _reload_requested := false
var _switch_requested := false
var _fire_held := false
var _sprint_held := false
var _viewport_size := Vector2.ZERO
var _joy_center := Vector2.ZERO
var _joy_radius := 82.0
var _fire_center := Vector2.ZERO
var _jump_center := Vector2.ZERO
var _reload_center := Vector2.ZERO
var _sprint_center := Vector2.ZERO
var _switch_center := Vector2.ZERO
var _button_radius := 39.0

func _ready() -> void:
	add_to_group("mobile_controls")
	_viewport_size = get_viewport().get_visible_rect().size
	_recalculate_layout()
	get_viewport().size_changed.connect(_on_viewport_size_changed)

func _on_viewport_size_changed() -> void:
	_viewport_size = get_viewport().get_visible_rect().size
	_recalculate_layout()
	queue_redraw()

func _recalculate_layout() -> void:
	var w := _viewport_size.x
	var h := _viewport_size.y
	_joy_center = Vector2(130.0, h - 145.0)
	_sprint_center = Vector2(250.0, h - 82.0)
	_fire_center = Vector2(w - 100.0, h - 125.0)
	_jump_center = Vector2(w - 218.0, h - 92.0)
	_reload_center = Vector2(w - 322.0, h - 92.0)
	_switch_center = Vector2(w - 105.0, h - 245.0)

func _process(_delta: float) -> void:
	queue_redraw()

func get_move_vector() -> Vector2:
	return _move_vector

func is_fire_held() -> bool:
	return _fire_held

func is_sprint_held() -> bool:
	return _sprint_held

func consume_jump() -> bool:
	var value := _jump_requested
	_jump_requested = false
	return value

func consume_reload() -> bool:
	var value := _reload_requested
	_reload_requested = false
	return value

func consume_weapon_switch() -> bool:
	var value := _switch_requested
	_switch_requested = false
	return value

func consume_look_delta() -> Vector2:
	var value := _look_delta
	_look_delta = Vector2.ZERO
	return value

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		_handle_touch(event.index, event.position, event.pressed)
	elif event is InputEventScreenDrag:
		_handle_drag(event.index, event.position, event.relative)

func _handle_touch(index: int, pos: Vector2, pressed: bool) -> void:
	if pressed:
		if pos.distance_to(_fire_center) <= _button_radius * 1.55 and _fire_touch == -1:
			_fire_touch = index
			_fire_held = true
		elif pos.distance_to(_jump_center) <= _button_radius * 1.4 and _jump_touch == -1:
			_jump_touch = index
			_jump_requested = true
		elif pos.distance_to(_reload_center) <= _button_radius * 1.4 and _reload_touch == -1:
			_reload_touch = index
			_reload_requested = true
		elif pos.distance_to(_switch_center) <= _button_radius * 1.45 and _switch_touch == -1:
			_switch_touch = index
			_switch_requested = true
		elif pos.distance_to(_sprint_center) <= _button_radius * 1.5 and _sprint_touch == -1:
			_sprint_touch = index
			_sprint_held = true
		elif pos.distance_to(_joy_center) <= _joy_radius * 1.9 and _move_touch == -1:
			_move_touch = index
			_update_move(pos)
		elif _look_touch == -1:
			_look_touch = index
	else:
		if index == _move_touch:
			_move_touch = -1
			_move_vector = Vector2.ZERO
		if index == _look_touch:
			_look_touch = -1
		if index == _fire_touch:
			_fire_touch = -1
			_fire_held = false
		if index == _jump_touch:
			_jump_touch = -1
		if index == _reload_touch:
			_reload_touch = -1
		if index == _sprint_touch:
			_sprint_touch = -1
			_sprint_held = false
		if index == _switch_touch:
			_switch_touch = -1
	queue_redraw()

func _handle_drag(index: int, pos: Vector2, relative: Vector2) -> void:
	if index == _move_touch:
		_update_move(pos)
	elif index == _look_touch:
		_look_delta += relative
	queue_redraw()

func _update_move(pos: Vector2) -> void:
	var offset := pos - _joy_center
	if offset.length() > _joy_radius:
		offset = offset.normalized() * _joy_radius
	_move_vector = Vector2(offset.x / _joy_radius, -offset.y / _joy_radius)

func _draw() -> void:
	if _viewport_size == Vector2.ZERO:
		return
	var player := get_tree().get_first_node_in_group("player")
	if player != null:
		var stats := "%s   HP %d   AMMO %d / %d" % [player.current_weapon_name, player.health, player.ammo, player.reserve_ammo]
		draw_string(ThemeDB.fallback_font, Vector2(26, 40), stats, HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color(0.95, 0.97, 0.94, 0.98))
	var center := _viewport_size * 0.5
	draw_line(center + Vector2(-10, 0), center + Vector2(-3, 0), Color.WHITE, 2.0)
	draw_line(center + Vector2(3, 0), center + Vector2(10, 0), Color.WHITE, 2.0)
	draw_line(center + Vector2(0, -10), center + Vector2(0, -3), Color.WHITE, 2.0)
	draw_line(center + Vector2(0, 3), center + Vector2(0, 10), Color.WHITE, 2.0)
	draw_circle(_joy_center, _joy_radius, Color(0.03, 0.08, 0.09, 0.30))
	draw_arc(_joy_center, _joy_radius, 0.0, TAU, 48, Color(0.75, 0.86, 0.82, 0.55), 3.0)
	draw_circle(_joy_center + Vector2(_move_vector.x, -_move_vector.y) * _joy_radius, 29.0, Color(0.85, 0.92, 0.88, 0.72))
	_draw_button(_fire_center, "FIRE", Color(0.85, 0.24, 0.13, 0.78), _fire_held, _button_radius)
	_draw_button(_jump_center, "JUMP", Color(0.12, 0.52, 0.75, 0.76), _jump_touch != -1, _button_radius * 0.88)
	_draw_button(_reload_center, "RELOAD", Color(0.68, 0.48, 0.12, 0.76), _reload_touch != -1, _button_radius * 0.88)
	_draw_button(_sprint_center, "RUN", Color(0.12, 0.48, 0.32, 0.76), _sprint_held, _button_radius * 0.82)
	_draw_button(_switch_center, "SWAP", Color(0.34, 0.36, 0.62, 0.78), false, _button_radius * 0.88)

func _draw_button(center: Vector2, label: String, color: Color, active: bool, radius: float) -> void:
	draw_circle(center, radius, color.lightened(0.18) if active else color)
	draw_arc(center, radius, 0.0, TAU, 40, Color(1, 1, 1, 0.78), 2.0)
	draw_string(ThemeDB.fallback_font, center + Vector2(-radius * 0.7, 5.0), label, HORIZONTAL_ALIGNMENT_CENTER, radius * 1.4, 13, Color.WHITE)
