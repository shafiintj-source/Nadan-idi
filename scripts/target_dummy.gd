extends StaticBody3D

@export var max_health: int = 100
var health: int

func _ready() -> void:
	health = max_health

func apply_damage(amount: int) -> void:
	health = maxi(0, health - amount)
	print("Target hit. HP: ", health)
	if health <= 0:
		health = max_health
		print("Target reset")
