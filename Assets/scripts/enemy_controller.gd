extends Node2D

signal SomeoneShouted(target:Vector2)

func _ready() -> void:
	var shouters = get_children_with_do("do_shout")
	var enemies = get_children_with_do("do_catch")
	print(shouters, enemies)
	if len(shouters) and len(enemies):
		for s:Node2D in shouters:
			s.find_child("do_shout").iHearADude.connect(_on_fart_smella_hears)
		for e:Node2D  in enemies:
			e.connect_ears(self, "SomeoneShouted")

func get_children_with_do(do: String) -> Array: #Находит Детей у которых есть нужный Do
	var result = []
	for child in get_children():
		for cc in child.get_children():
			if cc.name == do and result.count(child) == 0:
				result.append(child)
	return result


func _on_fart_smella_hears(target: Vector2) -> void:
	SomeoneShouted.emit(target)
