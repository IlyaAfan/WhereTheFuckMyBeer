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
	ConfigOption.burger += 1
	visible = false
	active = true
	name_body.speed -= 10
	name_body.not_catchable = true
	$"../Player/Gnom".scale = Vector2(1.9,1.9)
	await get_tree().create_timer(7).timeout
	name_body.speed += 10
	$"../Player/Gnom".scale = Vector2(1,1)
	$"../Player".not_catchable = false
	active = false


func _on_area_push_body_entered(body: Node2D) -> void:
	if active == true and body.is_in_group("Enemies"):
		body.position -= ($"../Player".position - body.position).normalized() * 30
		body.speed = 0
		await get_tree().create_timer(0.5).timeout
		body.speed = 70
