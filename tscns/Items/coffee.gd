extends StaticBody2D

var have = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if have == true:
		position = $"../Player".position + Vector2(0,-7)
	


func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.name_item == "empty":
		body.name_item = "coffee"
		have = true
		
func _use_coffee(body: Node2D) -> void:
	body.speed = 100
	print("coffee")
	await get_tree().create_timer(2.5).timeout 
	body.speed = 50
	print("end")
	queue_free()
