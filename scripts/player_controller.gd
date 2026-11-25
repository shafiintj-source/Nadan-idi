extends CharacterBody3D
## Offline third-person prototype controller with keyboard and touch support.

@export var move_speed: float = 6.0
@export var sprint_multiplier: float = 1.45
@export var acceleration: float = 20.0
@export var jump_velocity: float = 5.2
@export var mouse_sensitivity: float = 0.0025
@export var touch_look_sensitivity: float = 0.0032
@export var look_limit_degrees: float = 65.0
@export var max_health: int = 100

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var health: int
var _fire_cooldown := 0.0
var magazine_size: int = 30
var ammo: int = 30
var reserve_ammo: int = 120
var _reload_timer: float = 0.0
var _mobile_controls: Node
var _camera_pivot: Node3D
var _camera: Camera3D
var current_weapon_index: int = 0
var current_weapon_name: String = "ASSAULT RIFLE"
var current_damage: int = 20
var current_fire_interval: float = 0.12

func _ready() -> void:
	add_to_group("player")
	health = max_health
	_camera_pivot = $CameraPivot
	_camera = $CameraPivot/SpringArm3D/Camera3D
	_mobile_controls = get_tree().get_first_node_in_group("mobile_controls")
	if not OS.has_feature("android") and not OS.has_feature("ios"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED
		elif event.keycode == KEY_Q:
			_switch_weapon()
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
	if _reload_timer > 0.0:
		_reload_timer = maxf(0.0, _reload_timer - delta)
		if _reload_timer == 0.0:
			var loaded := mini(magazine_size - ammo, reserve_ammo)
			ammo += loaded
			reserve_ammo -= loaded
	if not is_on_floor():
		velocity.y -= gravity * delta

	var move_input := Vector2.ZERO
	var touch_fire := false
	var touch_jump := false
	var touch_sprint := false
	if _mobile_controls != null:
		move_input = _mobile_controls.get_move_vector()
		var look_delta: Vector2 = _mobile_controls.consume_look_delta()
		if look_delta != Vector2.ZERO:
			_rotate_camera(look_delta * touch_look_sensitivity)
		touch_fire = _mobile_controls.is_fire_held()
		touch_jump = _mobile_controls.consume_jump()
		touch_sprint = _mobile_controls.is_sprint_held()
		if _mobile_controls.consume_reload():
			_start_reload()
		if _mobile_controls.consume_weapon_switch():
			_switch_weapon()
	else:
		move_input.x = float(Input.is_key_pressed(KEY_D)) - float(Input.is_key_pressed(KEY_A))
		move_input.y = float(Input.is_key_pressed(KEY_W)) - float(Input.is_key_pressed(KEY_S))
		move_input = move_input.normalized()
		touch_fire = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
		touch_jump = Input.is_key_pressed(KEY_SPACE)
		touch_sprint = Input.is_key_pressed(KEY_SHIFT)
		if Input.is_key_pressed(KEY_R):
			_start_reload()

	var speed := move_speed * (sprint_multiplier if touch_sprint else 1.0)
	var yaw_basis := Basis(Vector3.UP, _camera_pivot.rotation.y)
	var move_direction := (yaw_basis * Vector3(move_input.x, 0.0, -move_input.y)).normalized()
	velocity.x = move_toward(velocity.x, move_direction.x * speed, acceleration * delta)
	velocity.z = move_toward(velocity.z, move_direction.z * speed, acceleration * delta)
	if is_on_floor() and touch_jump:
		velocity.y = jump_velocity
	move_and_slide()

	if touch_fire and _fire_cooldown <= 0.0 and _reload_timer <= 0.0:
		if ammo > 0:
			_fire_cooldown = current_fire_interval
			ammo -= 1
			_fire_hitscan()
		elif reserve_ammo > 0:
			_start_reload()

func _switch_weapon() -> void:
	current_weapon_index = (current_weapon_index + 1) % 2
	if current_weapon_index == 0:
		current_weapon_name = "ASSAULT RIFLE"
		current_damage = 20
		current_fire_interval = 0.12
		magazine_size = 30
	else:
		current_weapon_name = "SMG"
		current_damage = 13
		current_fire_interval = 0.075
		magazine_size = 40
	ammo = mini(ammo, magazine_size)

func _start_reload() -> void:
	if _reload_timer > 0.0 or ammo >= magazine_size or reserve_ammo <= 0:
		return
	_reload_timer = 1.25

func _fire_hitscan() -> void:
	if _camera == null:
		return
	var center := get_viewport().get_visible_rect().size * 0.5
	var origin := _camera.project_ray_origin(center)
	var direction := _camera.project_ray_normal(center)
	var query := PhysicsRayQueryParameters3D.create(origin, origin + direction * 120.0)
	query.exclude = [get_rid()]
	var result := get_world_3d().direct_space_state.intersect_ray(query)
	if result.is_empty():
		return
	var collider: Object = result.get("collider")
	if collider != null and collider.has_method("apply_damage"):
		collider.apply_damage(current_damage)

func apply_damage(amount: int) -> void:
	health = maxi(0, health - amount)
	if health == 0:
		global_position = Vector3(0, 1.0, 43)
		health = max_health
