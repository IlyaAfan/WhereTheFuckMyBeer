extends Area2D

var is_pressed: bool = false
@export var door: Obstacle

func press():
	$unpressed.visible = false
	if door:
		door.open()
	is_pressed = true

func unpress():
	$unpressed.visible = true
	if door:
		door.close()
	is_pressed = false


func _on_body_entered(_body: Node2D) -> void:
	press()


func _on_body_exited(_body: Node2D) -> void:
	unpress()
