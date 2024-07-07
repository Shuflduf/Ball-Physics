class_name Ball
extends MeshInstance3D

var velocity: Vector3 = Vector3(0, 0, 0)
var force: Vector3
var mass = 1.0

var radius = 0.5

func _ready() -> void:
	mesh.set_radius(radius)
	mesh.set_height(radius * 2)
