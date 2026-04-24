extends Node2D

signal FartSmellaHeard(target:Vector2)

func _ready() -> void:
	var fartsmellas = get_children_with_prefix("FartSmella")
	var enemies = get_children_with_prefix("Enemy")
	if len(fartsmellas) and len(enemies):
		for fs in fartsmellas:
			fs.iHearADude.connect(_on_fart_smella_hears)
		for e in enemies:
			e.connect_ears(self, "FartSmellaHeard")

func get_children_with_prefix(prefix: String) -> Array: #написал ИИ, работает нормально
	var result = []
	for child in get_children():
		if child.name.begins_with(prefix):
			result.append(child)
	return result
	
func _on_fart_smella_hears(target: Vector2) -> void:
	FartSmellaHeard.emit(target)
