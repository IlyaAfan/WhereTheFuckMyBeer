extends Node2D

var have = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if have == true:
		position = $"../Player".position + Vector2(0,-7)


func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.name_item == "empty":
		body.name_item = "pipe"
		have = true
		
func _use_pipe():
	visible = false
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		if "speed" in enemy:
			enemy.speed /= 2
	await get_tree().create_timer(5).timeout 
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		if "speed" in enemy:
			enemy.speed *= 2
	print("end")
	queue_free()
