extends Area2D
var active_body: Character
var active_body_speed: int

func use_jump_pad():
	var vect = (get_global_mouse_position()-global_position).normalized() * 48
	$RayCast2D.target_position = vect
	active_body.global_position += vect 
	active_body.speed = active_body_speed
	active_body = null

func _physics_process(_delta):
	if active_body:
		if Input.is_action_pressed("lmb"):
			use_jump_pad()
	
func _on_body_entered(body: Node2D) -> void:
	if !active_body:
		if body.is_in_group("Player"):
			active_body = body
			body.transform = transform
			active_body_speed = body.speed
			body.speed = 0

func _on_body_exited(body: Node2D) -> void:
	if active_body == body:
		active_body = null
