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
	ConfigOption.coffee += 1
	active = true
	name_body.coffee = true
	visible = false
	name_body.speed = 70
	print("coffee")
	await get_tree().create_timer(2.5).timeout 
	name_body.speed = 50
	print("end")
	name_body.coffee = false
	active = false
