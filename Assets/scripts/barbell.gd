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
		body.name_item = "barbell"
		have = true
		
func _use_barbell():
	#$"../Player/AnimatedSprite2D".play("train").
	print("barbell")
	await get_tree().create_timer(2.5).timeout #await $AnimationPlayer.animation_finished
	visible = false
	active = true
	$"../Player".not_catchable = true
	print("activeted")
	
	await get_tree().create_timer(7).timeout
	$"../Player".not_catchable = false
	active = false
	queue_free()


func _on_area_2d_body_entered_attack(body: Node2D) -> void:
	if active == true and body.is_in_group("Enemies"):
		var common_speed = body.speed
		body.speed = 0
		await get_tree().create_timer(3).timeout #Время действия оглушения
		body.speed = common_speed
		$"../Player".not_catchable = false
