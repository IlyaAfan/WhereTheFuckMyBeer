extends Control

func toggle_menu(object: Control = self):
	object.visible = !object.visible

func _ready() -> void:
	visible = false

func _on_try_again_pressed() -> void:
	get_tree().reload_current_scene()
