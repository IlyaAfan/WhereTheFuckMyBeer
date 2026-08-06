extends Area2D

func _ready() -> void:
	visible = false

func put_enemy_destination(dest:Vector2):
	position = dest
	visible = true

func _on_body_entered(body: Node2D) -> void:
	if visible and body.is_in_group("Enemies"):
		visible = false
