extends Character
var not_catchable = true

func _physics_process(delta: float) -> void:
	if $"..".activated:
		$PlayerBox.disabled = false
		velocity.y = -$"../../Player".velocity.y
		velocity.x = $"../../Player".velocity.x
	else:
		$PlayerBox.disabled = true
	move_and_slide()
