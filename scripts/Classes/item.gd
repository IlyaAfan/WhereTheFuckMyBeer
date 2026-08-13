extends Node2D

class_name item

var have = false
var name_body: Character
var active: bool = false

func located():
	if have == true:
		position = name_body.position + Vector2(0,-10)
	


func get_up(body: Node2D) -> void:
	if body.name == "Player" and not body.have_item:
		name_body = body
		have = true
		body.have_item = true
		
func use_item():
	if Input.is_action_just_pressed("use_item") and have and not active:
		name_body.have_item = false
		await activate_item() 
		ConfigOption.save_game_stat()
		if active == false:
			queue_free()

func activate_item():
	pass
