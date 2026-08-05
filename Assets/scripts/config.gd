extends Control

var config
var path_to_save_file = "user://settings.cfg"
var section_name = "option"
var section_stats = "stats"
var type_control = false

var coffee = 0
var pipe = 0
var burger = 0
var cats = 0
var barbell = 0
var gold = 0
var beer = 0
 
func _ready() -> void:
	load_game()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func save_game():
	config.set_value(section_name,"TypeControl",type_control)
	config.save(path_to_save_file)

func load_game():
	config = ConfigFile.new()
	config.load(path_to_save_file)
	type_control = config.get_value(section_name,"TypeControl",type_control)


func load_game_stat():
	config = ConfigFile.new()
	config.load(path_to_save_file)
	pipe = config.get_value(section_stats,"pipe",pipe)
	coffee = config.get_value(section_stats,"coffee",coffee)
	cats = config.get_value(section_stats,"cats",cats)
	burger = config.get_value(section_stats,"burger",burger)
	barbell = config.get_value(section_stats,"barbell",barbell)
	beer = config.get_value(section_stats,"beer",beer)
	gold = config.get_value(section_stats,"gold",gold)
	
func save_game_stat():
	config.save(path_to_save_file)
	config.set_value(section_stats,"pipe",pipe)
	config.set_value(section_stats,"coffee",coffee)
	config.set_value(section_stats,"cats",cats)
	config.set_value(section_stats,"burger",burger)
	config.set_value(section_stats,"barbell",barbell)
	config.set_value(section_stats,"beer",beer)
	config.set_value(section_stats,"gold",gold)
	
		
