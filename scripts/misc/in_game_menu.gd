extends Control

func _ready(): 
	$NinePatchRect/PopupMenu.visible = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_menu($NinePatchRect/PopupMenu)
		get_tree().paused = not get_tree().paused

func toggle_menu(object: Control = self):
	object.visible = !object.visible

func _on_resume_pressed() -> void:
	print("resume")
	get_tree().paused = not get_tree().paused
	toggle_menu($NinePatchRect/PopupMenu)


func _on_main_menu_pressed() -> void:
	print("main menu")
	get_tree().paused = not get_tree().paused
	get_tree().change_scene_to_file.bind("res://tscns/menus/menu.tscn").call_deferred()


func _on_quit_game_pressed() -> void:
	print("quit")
	get_tree().quit()


func _on_menu_button_pressed() -> void:
	print("ingame menu")
	get_tree().paused = not get_tree().paused
	toggle_menu($NinePatchRect/PopupMenu)


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
