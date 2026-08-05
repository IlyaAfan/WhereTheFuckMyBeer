extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ConfigOption.load_game_stat()
	$ScrollContainer/VBoxContainer/Beer.text = "Beer:" + str(ConfigOption.beer)
	$ScrollContainer/VBoxContainer/gold.text = "Gold:" + str(ConfigOption.gold)
	$ScrollContainer/VBoxContainer/coffee.text = "Coffee:" + str(ConfigOption.coffee)
	$ScrollContainer/VBoxContainer/pipe.text = "Pipe:" + str(ConfigOption.pipe)
	$ScrollContainer/VBoxContainer/burger.text = "Burger:" + str(ConfigOption.burger)
	$ScrollContainer/VBoxContainer/cats.text = "Cats: " + str(ConfigOption.cats)
	$ScrollContainer/VBoxContainer/barbell.text = "Barbell: " + str(ConfigOption.barbell)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://tscns/menus/menu.tscn")
