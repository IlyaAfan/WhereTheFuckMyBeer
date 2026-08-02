extends Area2D
var active_body: Character
var active_body_speed: int
var vect: Vector2
var holding: bool
@export var jump_range: int = 64
func use_jump_pad():
	if $RayCast2D.is_colliding():
		active_body.global_position = $RayCast2D.get_collision_point()
	else:
		active_body.global_position += vect 
	
	active_body.speed = active_body_speed
	active_body.Navigation_Agent_Used.target_position = get_global_mouse_position()
	active_body = null

func _physics_process(_delta):
	if active_body:
		print(holding)
		if holding:
			vect = (get_global_mouse_position()-global_position).normalized() * jump_range
			$RayCast2D.target_position = vect
			$RayCast2D.force_update_transform()
			if $RayCast2D.is_colliding():
				$Line2D.points = [Vector2.ZERO,$RayCast2D.get_collision_point()-global_position]
			else:
				$Line2D.points = [Vector2.ZERO, vect]
			$Goal.position = $Line2D.points[1]
		
		if Input.is_action_pressed("lmb"):
			$Line2D.visible = true
			$Goal.visible = true
			holding = true
		
		if holding and Input.is_action_just_released("lmb"):
			use_jump_pad()
			$Line2D.visible = false
			$Goal.visible = false
			holding = false
	
func _on_body_entered(body: Node2D) -> void:
	if !active_body:
		if body.is_in_group("Player"):
			active_body = body
			body.transform = transform
			active_body_speed = body.speed
			body.speed = 0
			body.stop_navigation()

func _on_body_exited(body: Node2D) -> void:
	if active_body == body:
		active_body = null
