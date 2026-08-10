extends Character

var not_catchable = true
var active: bool = false


func _physics_process(delta: float) -> void:
	if active:
		$PlayerBox.disabled = false
		var player = $"../Player"
		velocity.x = player.velocity.x
		velocity.y = -player.velocity.y
	else:
		$PlayerBox.disabled = true
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		queue_free()
