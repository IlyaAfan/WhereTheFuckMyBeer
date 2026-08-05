extends Control

var config
var path_to_save_file = "user://settings.cfg"
var section_name = "option"
var type_control = false
 
func _ready() -> void:
	load_game()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func save_game():
	config.set_value(section_name,"TypeControl",type_control)
	config.save(path_to_save_file)

func load_game():
	pass
	config = ConfigFile.new()
	config.load(path_to_save_file)
	type_control = config.get_value(section_name,"TypeControl",type_control)
