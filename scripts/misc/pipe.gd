extends item

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	located()
	use_item()


func _on_area_body_entered(body: Node2D) -> void:
	get_up(body)
		
func activate_item():
	ConfigOption.pipe += 1
	active = true
	print("Pipe")
	visible = false
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		if "speed" in enemy:
			enemy.speed = 40
	await get_tree().create_timer(5).timeout 
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		if "speed" in enemy:
			enemy.speed = 70
	print("end")
	active = false
	
	
