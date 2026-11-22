extends CharacterBody3D
## Offline third-person prototype controller. Keyboard/mouse in editor,
## touch controls when running on a touchscreen.

@export var move_speed: float = 6.0
@export var acceleration: float = 18.0
@export var jump_velocity: float = 5.2
@export var mouse_sensitivity: float = 0.0025
@export var touch_look_sensitivity: float = 0.004
@export var look_limit_degrees: float = 65.0
@export var fire_interval: float = 0.18
@export var max_health: int = 100

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var health: int
var _fire_cooldown := 0.0
var _mobile_controls: Node
var _camera_pivot: Node3D
var _camera: Camera3D

func _ready() -> void:
	health = max_health
	_camera_pivot = $CameraPivot
	_camera = $CameraPivot/SpringArm3D/Camera3D
	_mobile_controls = get_tree().get_first_node_in_group("mobile_controls")
	if not OS.has_feature("android") and not OS.has_feature("ios"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		_rotate_camera(event.relative * mouse_sensitivity)

func _rotate_camera(delta: Vector2) -> void:
	_camera_pivot.rotate_y(-delta.x)
	_camera_pivot.rotate_x(-delta.y)
	var limit := deg_to_rad(look_limit_degrees)
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -limit, limit)

func _physics_process(delta: float) -> void:
	if _mobile_controls == null:
		_mobile_controls = get_tree().get_first_node_in_group("mobile_controls")
	_fire_cooldown = maxf(0.0, _fire_cooldown - delta)
	if not is_on_floor():
		velocity.y -= gravity * delta

	var move_input := Vector2.ZERO
	var touch_fire := false
	var touch_jump := false
	if _mobile_controls != null:
		move_input = _mobile_controls.get_move_vector()
		var look_delta: Vector2 = _mobile_controls.consume_look_delta()
		if look_delta != Vector2.ZERO:
			_rotate_camera(look_delta * touch_look_sensitivity)
		touch_fire = _mobile_controls.is_fire_held()
		touch_jump = _mobile_controls.consume_jump()
		if _mobile_controls.consume_reload():
			print("Reload requested — weapon system milestone pending")
	else:
		move_input.x = float(Input.is_key_pressed(KEY_D)) - float(Input.is_key_pressed(KEY_A))
		move_input.y = float(Input.is_key_pressed(KEY_W)) - float(Input.is_key_pressed(KEY_S))
		move_input = move_input.normalized()
		touch_fire = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
		touch_jump = Input.is_key_pressed(KEY_SPACE)

	var yaw_basis := Basis(Vector3.UP, _camera_pivot.rotation.y)
	var move_direction := (yaw_basis * Vector3(move_input.x, 0.0, -move_input.y)).normalized()
	var target_x := move_direction.x * move_speed
	var target_z := move_direction.z * move_speed
	velocity.x = move_toward(velocity.x, target_x, acceleration * delta)
	velocity.z = move_toward(velocity.z, target_z, acceleration * delta)

	if is_on_floor() and touch_jump:
		velocity.y = jump_velocity

	move_and_slide()
	if touch_fire and _fire_cooldown <= 0.0:
		_fire_cooldown = fire_interval
		_fire_hitscan()

func _fire_hitscan() -> void:
	if _camera == null:
		return
	var viewport := get_viewport()
	var center := viewport.get_visible_rect().size * 0.5
	var origin := _camera.project_ray_origin(center)
	var direction := _camera.project_ray_normal(center)
	var query := PhysicsRayQueryParameters3D.create(origin, origin + direction * 120.0)
	query.exclude = [get_rid()]
	var result := get_world_3d().direct_space_state.intersect_ray(query)
	if result.is_empty():
		return
	var collider: Object = result.get("collider")
	if collider != null and collider.has_method("apply_damage"):
		collider.apply_damage(25)

func apply_damage(amount: int) -> void:
	health = maxi(0, health - amount)
	if health == 0:
		global_position = Vector3(0, 1.0, 5.0)
		health = max_health
