class_name Ball
extends MeshInstance3D

var velocity: Vector3
var radius = 0.5

func _ready() -> void:
	mesh.set_radius(radius)
	mesh.set_height(radius * 2)
