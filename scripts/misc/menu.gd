extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file.bind("res://tscns/levels/test_level.tscn").call_deferred()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_choose_level_pressed() -> void:
	get_tree().change_scene_to_file.bind("res://tscns/menus/choose_level_menu.tscn").call_deferred()


func _on_optiion_pressed() -> void:
	get_tree().change_scene_to_file("res://tscns/menus/option.tscn")
