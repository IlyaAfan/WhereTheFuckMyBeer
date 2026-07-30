extends StaticBody2D

var have = false
var active = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if have == true:
		position = $"../Player".position + Vector2(0,-7)


func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.name_item == "empty":
		body.name_item = "burger"
		have = true
		
func _use_burger(body: Node2D) -> void:
	visible = false
	active = true
	body.speed /= 1.2
	body.fat = true
	$"../Player/Gnom".scale = Vector2(1.9,1.9)


func _on_area_push_body_entered(body: Node2D) -> void:
	if active == true and body.is_in_group("Enemies"):
		$"../Player".position += ($"../Player".position - body.position).normalized() * 30
		$"../Player/PlayerBox".scale = Vector2(1,1)
		$"../Player/Gnom".scale = Vector2(1,1)
		await get_tree().create_timer(0.1).timeout
		$"../Player".fat = false
		queue_free()
