extends Node2D

var have = false
var active = false
var holding_a_dude = false
var common_speed
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
		$Area.collision_layer = 0
		$Area.collision_mask = 0
		
func _use_barbell():
	#$"../Player/AnimatedSprite2D".play("train").
	print("barbell")
	$"../Player".speed = 0
	await get_tree().create_timer(2.5).timeout #await $AnimationPlayer.animation_finished
	visible = false
	active = true
	$"../Player".not_catchable = true
	$"../Player".speed = 60
	
	await get_tree().create_timer(7).timeout
	if !holding_a_dude:
		$"../Player".not_catchable = false
	active = false
	
	await get_tree().create_timer(3).timeout
	$"../Player".not_catchable = false
	queue_free()


func _on_area_2d_body_entered_attack(body: Node2D) -> void:
	if active == true and body.is_in_group("Enemies"):
		if !body.speed==0:
			common_speed = body.speed
			body.speed = 0
		holding_a_dude = true
		$Timer.start()
		await $Timer.timeout #Время действия оглушения
		body.speed = common_speed
		holding_a_dude = false
