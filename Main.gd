extends Node3D

@onready var balls: Node3D = $Balls
@onready var plane: MeshInstance3D = $Plane

@export var ball_scene: PackedScene
@export var plane_depth: int

@export var gravity: float
@export_range(0, 1, 0.1) var damping: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plane.position.y = plane_depth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for ball: Ball in balls.get_children():
		ball.velocity.y -= delta * gravity
		
		
		if ball.position.y - ball.radius + ball.velocity.y < plane_depth:
			ball.velocity.y *= -damping
			
		ball.position += ball.velocity

func create_ball(pos):
	var new_ball: Node3D = ball_scene.instantiate()
	new_ball.position = pos
	balls.add_child(new_ball)


func _on_area_3d_input_event(_camera: Node, event: InputEvent, input_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		create_ball(input_position + Vector3(0, 10, 0))
