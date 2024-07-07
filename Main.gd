extends Node3D

@onready var balls: Node3D = $Balls
@onready var plane: MeshInstance3D = $Plane

@export var ball_scene: PackedScene
@export var plane_depth: int

const GRAVITY = -9.81

@export_range(0, 1, 0.1) var damping: float
@export_range(0, 1, 0.01) var friction: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plane.position.y = plane_depth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for ball: Ball in balls.get_children():
		ball.force += ball.mass * Vector3(0, GRAVITY, 0)
		ball.velocity += ball.force / ball.mass * delta
		
		if ball.position.y - ball.radius + (ball.velocity.y * delta) < plane_depth:
			ball.velocity.y *= -damping
			
		for other_ball: Ball in balls.get_children():
			if other_ball == ball:
				continue
			if (ball.position - other_ball.position).length() < 1:
				print("ah")
		
		ball.position += ball.velocity * delta
		
		ball.force = Vector3.ZERO	

func create_ball(pos):
	var new_ball: Node3D = ball_scene.instantiate()
	new_ball.position = pos
	balls.add_child(new_ball)


func _on_area_3d_input_event(_c, event: InputEvent, input_position: Vector3, _n, _s) -> void:
	if event.is_action_pressed("left_click"):
		create_ball(input_position + Vector3(0, -plane_depth, 0))


func report_collision(first_ball, second_ball):
	pass
