extends Node2D

var have = false
var player: Character


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if have == true:
		player.position = position + Vector2(0,-7)
	


func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.name_item == "empty":
		player = body
		body.name_item = "coffee"
		have = true
		
func _use_coffee(body: Node2D) -> void:
	visible = false
	body.speed = 100
	print("coffee")
	await get_tree().create_timer(2.5).timeout 
	body.speed = 50
	print("end")
	queue_free()
