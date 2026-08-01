extends Control

@export var LevelButton: PackedScene


func GetAllFiles(path: String, require: String): #не раскрывать не имея запланированных встреч с психологом
	var files = []
	var buttons = []
	var dir = DirAccess.open(path)
	var i = 0 as int
	
	if dir:
		dir.list_dir_begin()
		var FileName = dir.get_next()
		while FileName != "":
			if require in FileName:
				files.append(path + "/" + FileName.replace(".remap","")) # я не ебу что такое ремап, не вздумайте меня спрашивать
				$base_container/VBoxContainer/level_buttons.add_child(LevelButton.instantiate())
				buttons = $base_container/VBoxContainer/level_buttons.get_children()
				buttons[i].whereto = files[i]
				buttons[i].text = FileName.replace(".remap","").replace(".tscn","")
				i+=1
			FileName = dir.get_next() #нам повезло что я увидел что это говно находится в if до того как это сломало всё к хуям через 2 года. Сейчас этот баг занял у меня всего 2 часа на поиск причины, через год мне было бы проще переписать экран уровней.
		#это очень уродливо, хотя теперь не разбросано на 3 разных цикла, но всё же
		#но мне поебать, оно остаётся так пока кто-нибудь это не исправит
		#в ready оно должно заспавнить кнопки соответсвующие всем уровням в папке levels, пробежав по папке, сделав кнопки и назвав их соответсвующе
		#так и вышла эта гигансткая поебота выше


func _ready():
	GetAllFiles("res://tscns/levels/", ".tscn")

func _on_back_to_main_pressed() -> void:
	get_tree().change_scene_to_file("res://tscns/menus/menu.tscn")
