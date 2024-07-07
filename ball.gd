class_name Ball
extends MeshInstance3D

var velocity: Vector3 = Vector3(0, 0, 0)
var force: Vector3
var mass = 1.0

var radius = 0.5

func set_radius(new_radius):
	var new_mesh = SphereMesh.new()
	new_mesh.radius = new_radius
	new_mesh.height = new_radius * 2
	radius = new_radius
	
	mesh = new_mesh

	
