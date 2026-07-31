extends Control

 
func _ready() -> void:
	ConfigOption.load_game()
	$HeadScreen/NinePatchRect/HBoxContainer/VBoxContainer/ButtonTypeControl.text = "Тип Управления: Мышь" if ConfigOption.type_control == true else "Тип Управления: Клавиатура"
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://tscns/menus/menu.tscn")


func _on_button_type_control_pressed() -> void:
	ConfigOption.type_control = not ConfigOption.type_control
	ConfigOption.save_game()
	$HeadScreen/NinePatchRect/HBoxContainer/VBoxContainer/ButtonTypeControl.text = "Тип Управления: Мышь" if ConfigOption.type_control == true else "Тип Управления: Клавиатура"


	
