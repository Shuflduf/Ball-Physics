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
	var all_balls = balls.get_children()
	
	for ball: Ball in all_balls:
		ball.force += ball.mass * Vector3(0, GRAVITY, 0)
		ball.velocity += ball.force / ball.mass * delta
		
		if ball.position.y - ball.radius + (ball.velocity.y * delta) < plane_depth:
			ball.velocity.y *= -damping
			
		for other_ball: Ball in all_balls:
			if other_ball == ball:
				continue
			if (ball.position - other_ball.position).length() < ball.radius + other_ball.radius:
				report_collision(ball, other_ball)
		
		ball.position += ball.velocity * delta
		
		ball.force = Vector3.ZERO	

func create_ball(pos):
	var new_ball: Node3D = ball_scene.instantiate()
	new_ball.position = pos
	balls.add_child(new_ball)


func _on_area_3d_input_event(_c, event, input_position, _n, _s) -> void:
	if event.is_action_pressed("left_click"):
		create_ball(input_position + Vector3(0, 5, 0))


func report_collision(first_ball: Ball, second_ball: Ball):
	var impulse = (first_ball.position + first_ball.velocity)\
		 - (second_ball.position + second_ball.velocity)
	
	impulse = impulse.normalized()
	
	print(impulse)
	
	first_ball.velocity += impulse
	second_ball.velocity -= impulse
