extends Node3D

@onready var balls: Node3D = $Balls
@onready var plane: MeshInstance3D = $Plane

@export var ball_scene: PackedScene
@export var plane_depth: int

var ball_velocities: Array[Vector3]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plane.position.y = plane_depth
	ball_velocities.resize(balls.get_child_count())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_ball(pos):
	var new_ball: Node3D = ball_scene.instantiate()
	new_ball.position = pos
	balls.add_child(new_ball)
	ball_velocities.resize(ball_velocities.size() + 1)
