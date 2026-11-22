extends CanvasLayer
## Lightweight touch HUD for Android prototype.
## Left thumb moves; right thumb drags camera; action buttons are on the right.

var _move_touch := -1
var _look_touch := -1
var _fire_touch := -1
var _jump_touch := -1
var _reload_touch := -1
var _move_vector := Vector2.ZERO
var _look_delta := Vector2.ZERO
var _jump_requested := false
var _reload_requested := false
var _fire_held := false
var _viewport_size := Vector2.ZERO
var _joy_center := Vector2.ZERO
var _joy_radius := 78.0
var _fire_center := Vector2.ZERO
var _jump_center := Vector2.ZERO
var _reload_center := Vector2.ZERO
var _button_radius := 42.0

func _ready() -> void:
	add_to_group("mobile_controls")
	_viewport_size = get_viewport().get_visible_rect().size
	_recalculate_layout()
	get_viewport().size_changed.connect(_on_viewport_size_changed)
	set_process(true)

func _on_viewport_size_changed() -> void:
	_viewport_size = get_viewport().get_visible_rect().size
	_recalculate_layout()
	queue_redraw()

func _recalculate_layout() -> void:
	var w := _viewport_size.x
	var h := _viewport_size.y
	_joy_center = Vector2(125.0, h - 135.0)
	_fire_center = Vector2(w - 105.0, h - 125.0)
	_jump_center = Vector2(w - 225.0, h - 95.0)
	_reload_center = Vector2(w - 325.0, h - 95.0)

func get_move_vector() -> Vector2:
	return _move_vector

func is_fire_held() -> bool:
	return _fire_held

func consume_jump() -> bool:
	var value := _jump_requested
	_jump_requested = false
	return value

func consume_reload() -> bool:
	var value := _reload_requested
	_reload_requested = false
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
		if pos.distance_to(_fire_center) <= _button_radius * 1.45 and _fire_touch == -1:
			_fire_touch = index
			_fire_held = true
		elif pos.distance_to(_jump_center) <= _button_radius * 1.35 and _jump_touch == -1:
			_jump_touch = index
			_jump_requested = true
		elif pos.distance_to(_reload_center) <= _button_radius * 1.35 and _reload_touch == -1:
			_reload_touch = index
			_reload_requested = true
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
	draw_circle(_joy_center, _joy_radius, Color(0.03, 0.08, 0.09, 0.30))
	draw_arc(_joy_center, _joy_radius, 0.0, TAU, 48, Color(0.75, 0.86, 0.82, 0.55), 3.0)
	draw_circle(_joy_center + Vector2(_move_vector.x, -_move_vector.y) * _joy_radius, 28.0, Color(0.85, 0.92, 0.88, 0.68))
	_draw_button(_fire_center, "FIRE", Color(0.85, 0.24, 0.13, 0.72), _fire_held)
	_draw_button(_jump_center, "JUMP", Color(0.12, 0.52, 0.75, 0.72), _jump_touch != -1)
	_draw_button(_reload_center, "RELOAD", Color(0.68, 0.48, 0.12, 0.72), _reload_touch != -1)

func _draw_button(center: Vector2, label: String, color: Color, active: bool) -> void:
	draw_circle(center, _button_radius, color.lightened(0.18) if active else color)
	draw_arc(center, _button_radius, 0.0, TAU, 40, Color(1, 1, 1, 0.75), 2.0)
	draw_string(ThemeDB.fallback_font, center + Vector2(-_button_radius * 0.65, 5.0), label, HORIZONTAL_ALIGNMENT_CENTER, _button_radius * 1.3, 14, Color.WHITE)
