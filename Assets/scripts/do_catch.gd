extends Node2D

@export var radius = 8

func _ready() -> void:
	$Area2D/CollisionShape2D.shape.radius = radius

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.fat == false:
		body.get_caught()
		
		get_parent().set_deferred("process_mode",Node.PROCESS_MODE_DISABLED)
