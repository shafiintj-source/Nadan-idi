extends CharacterBody3D
## Keyboard/mouse placeholder controller for the first editor prototype.
## Mobile touch controls are a separate planned milestone.

@export var move_speed: float = 6.0
@export var jump_velocity: float = 5.0
@export var mouse_sensitivity: float = 0.0025
@export var look_limit_degrees: float = 65.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera_pivot: Node3D = $CameraPivot

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		camera_pivot.rotate_y(-event.relative.x * mouse_sensitivity)
		camera_pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		var limit := deg_to_rad(look_limit_degrees)
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -limit, limit)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	var move_input := Vector2.ZERO
	move_input.x = float(Input.is_key_pressed(KEY_D)) - float(Input.is_key_pressed(KEY_A))
	move_input.y = float(Input.is_key_pressed(KEY_S)) - float(Input.is_key_pressed(KEY_W))
	move_input = move_input.normalized()

	var yaw_basis := Basis(Vector3.UP, camera_pivot.rotation.y)
	var move_direction := (yaw_basis * Vector3(move_input.x, 0.0, move_input.y)).normalized()

	velocity.x = move_direction.x * move_speed
	velocity.z = move_direction.z * move_speed

	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y = jump_velocity

	move_and_slide()
