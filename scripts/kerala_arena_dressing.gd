extends Node3D
## Procedural placeholder dressing for the first fictional Kerala village arena.
## Replace primitives with original optimized art assets after gameplay validation.

func _ready() -> void:
	_make_box(Vector3(-7.0, 1.0, -3.0), Vector3(4.0, 2.0, 3.0), Color(0.58, 0.36, 0.22))
	var tiled_roof := _make_box(Vector3(-7.0, 2.25, -3.0), Vector3(4.5, 0.5, 3.5), Color(0.35, 0.16, 0.12))
	tiled_roof.rotation.z = deg_to_rad(-8.0)
	_make_box(Vector3(7.0, 1.0, -6.0), Vector3(4.0, 2.0, 3.5), Color(0.66, 0.54, 0.36))
	_make_box(Vector3(0.0, 0.55, -11.0), Vector3(3.5, 1.1, 1.2), Color(0.25, 0.32, 0.28))
	_make_box(Vector3(-3.5, 0.55, 2.0), Vector3(1.8, 1.1, 1.8), Color(0.38, 0.27, 0.18))
	_make_box(Vector3(4.5, 0.55, 1.0), Vector3(1.8, 1.1, 1.8), Color(0.38, 0.27, 0.18))
	_make_hill(Vector3(-15.0, -1.0, -18.0), Vector3(12.0, 5.0, 5.0), Color(0.10, 0.27, 0.18))
	_make_hill(Vector3(13.0, -1.0, -20.0), Vector3(14.0, 6.0, 6.0), Color(0.12, 0.32, 0.20))
	_make_palm(Vector3(-13.0, 0.0, 1.0))
	_make_palm(Vector3(12.0, 0.0, 3.0))
	_make_palm(Vector3(10.0, 0.0, -13.0))

func _make_box(pos: Vector3, box_size: Vector3, tint: Color, solid: bool = true) -> StaticBody3D:
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
	if solid:
		var collision := CollisionShape3D.new()
		var shape := BoxShape3D.new()
		shape.size = box_size
		collision.shape = shape
		body.add_child(collision)
	return body

func _make_hill(pos: Vector3, hill_scale: Vector3, tint: Color) -> void:
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

func _make_palm(pos: Vector3) -> void:
	var trunk := MeshInstance3D.new()
	var trunk_mesh := CylinderMesh.new()
	trunk_mesh.top_radius = 0.12
	trunk_mesh.bottom_radius = 0.24
	trunk_mesh.height = 5.5
	var bark := StandardMaterial3D.new()
	bark.albedo_color = Color(0.30, 0.20, 0.12)
	trunk_mesh.material = bark
	trunk.mesh = trunk_mesh
	trunk.position = pos + Vector3(0, 2.75, 0)
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
	crown.position = pos + Vector3(0, 5.35, 0)
	crown.scale = Vector3(1.5, 0.55, 1.5)
	add_child(crown)
