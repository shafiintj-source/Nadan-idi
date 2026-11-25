extends Node3D
## Larger fictional Kerala village combat space. Primitive geometry is a greybox; replace with optimized original art later.

const BUILDING := Color(0.56, 0.38, 0.25)
const ROOF := Color(0.30, 0.15, 0.11)
const COVER := Color(0.28, 0.34, 0.29)
const GREEN := Color(0.10, 0.29, 0.18)

func _ready() -> void:
	_add_boundary_walls()
	_add_house(Vector3(-24, 0, -24), Vector3(12, 5, 9))
	_add_house(Vector3(25, 0, -29), Vector3(13, 5, 10))
	_add_house(Vector3(-29, 0, 17), Vector3(10, 4.5, 8))
	_add_house(Vector3(30, 0, 25), Vector3(12, 5, 9))
	_add_cover_lane(Vector3(-8, 0, -6), 5)
	_add_cover_lane(Vector3(12, 0, 13), 5)
	_add_cover_lane(Vector3(-17, 0, 34), 3)
	_add_palm(Vector3(-43, 0, -8))
	_add_palm(Vector3(43, 0, -12))
	_add_palm(Vector3(-43, 0, 38))
	_add_palm(Vector3(44, 0, 43))
	_add_palm(Vector3(-40, 0, -43))
	_add_palm(Vector3(40, 0, -43))
	_add_hill(Vector3(-50, -1, -48), Vector3(18, 7, 12), GREEN)
	_add_hill(Vector3(52, -1, -45), Vector3(16, 8, 13), Color(0.13, 0.32, 0.20))
	_add_hill(Vector3(-52, -1, 48), Vector3(17, 7, 12), Color(0.12, 0.30, 0.19))

func _add_boundary_walls() -> void:
	_add_box(Vector3(0, 2, -59), Vector3(120, 4, 2), Color(0.18, 0.25, 0.22))
	_add_box(Vector3(0, 2, 59), Vector3(120, 4, 2), Color(0.18, 0.25, 0.22))
	_add_box(Vector3(-59, 2, 0), Vector3(2, 4, 120), Color(0.18, 0.25, 0.22))
	_add_box(Vector3(59, 2, 0), Vector3(2, 4, 120), Color(0.18, 0.25, 0.22))

func _add_house(pos: Vector3, size: Vector3) -> void:
	_add_box(pos + Vector3(0, size.y * 0.5, 0), size, BUILDING)
	_add_box(pos + Vector3(0, size.y + 0.45, 0), Vector3(size.x + 1.4, 0.9, size.z + 1.4), ROOF)

func _add_cover_lane(origin: Vector3, count: int) -> void:
	for i in range(count):
		var offset := float(i) * 6.0
		_add_box(origin + Vector3(offset - float(count) * 3.0, 0.9, 0), Vector3(3.2, 1.8, 1.2), COVER)
		_add_box(origin + Vector3(0, 0.65, offset - float(count) * 3.0), Vector3(1.2, 1.3, 3.2), Color(0.38, 0.31, 0.22))

func _add_box(pos: Vector3, box_size: Vector3, tint: Color) -> StaticBody3D:
	var body := StaticBody3D.new()
	body.position = pos
	add_child(body)
	var mesh_instance := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = box_size
	var material := StandardMaterial3D.new()
	material.albedo_color = tint
	material.roughness = 0.92
	mesh.material = material
	mesh_instance.mesh = mesh
	body.add_child(mesh_instance)
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = box_size
	collision.shape = shape
	body.add_child(collision)
	return body

func _add_hill(pos: Vector3, hill_scale: Vector3, tint: Color) -> void:
	var hill := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = 1.0
	sphere.height = 2.0
	var material := StandardMaterial3D.new()
	material.albedo_color = tint
	material.roughness = 1.0
	sphere.material = material
	hill.mesh = sphere
	hill.position = pos
	hill.scale = hill_scale
	add_child(hill)

func _add_palm(pos: Vector3) -> void:
	var trunk := MeshInstance3D.new()
	var trunk_mesh := CylinderMesh.new()
	trunk_mesh.top_radius = 0.12
	trunk_mesh.bottom_radius = 0.24
	trunk_mesh.height = 6.5
	var bark := StandardMaterial3D.new()
	bark.albedo_color = Color(0.30, 0.20, 0.12)
	trunk_mesh.material = bark
	trunk.mesh = trunk_mesh
	trunk.position = pos + Vector3(0, 3.25, 0)
	trunk.rotation.z = deg_to_rad(-7.0)
	add_child(trunk)
	var crown := MeshInstance3D.new()
	var crown_mesh := SphereMesh.new()
	crown_mesh.radius = 1.1
	crown_mesh.height = 1.1
	var leaf := StandardMaterial3D.new()
	leaf.albedo_color = Color(0.10, 0.34, 0.17)
	crown_mesh.material = leaf
	crown.mesh = crown_mesh
	crown.position = pos + Vector3(0, 6.3, 0)
	crown.scale = Vector3(1.5, 0.55, 1.5)
	add_child(crown)
