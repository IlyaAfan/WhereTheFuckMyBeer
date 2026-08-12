extends Character

signal caught
var input_direction: Vector2
var navigated: bool
var was_caught: bool = false
var have_item: bool = false
var not_catchable: bool = false
var acceltration = 0.05
var friction = 0.05
var turn_accel = 0.03
var now_velocity: Vector2
var run_velocity: Vector2
var coffee = false

func get_caught():
	caught.emit()
	was_caught = true
	speed = 0

func _ready():
	ConfigOption.load_game_stat()
	add_to_group("Player")
	navigated = false
	Navigation_Agent_Used = $NavigationAgent2D
	TileMap_I_Am_Standing_On = get_tree().get_first_node_in_group("TileMap")
	$destination.visible = false

func _physics_process(_delta: float) -> void:
	if ConfigOption.type_control:
		velocity = nav_movement()
		
		if Input.is_action_pressed("lmb"):
			Navigation_Agent_Used.target_position = get_global_mouse_position()
			put_destination(Navigation_Agent_Used.target_position)
			navigated = true
		
		if Navigation_Agent_Used.is_navigation_finished():
			navigated = false
			$destination.visible = false
	else:
		velocity = input_movement()
		
	if Input.is_action_just_pressed("change_input_dev"):
		velocity = Vector2.ZERO
		stop_navigation()
		ConfigOption.type_control = not ConfigOption.type_control
		$destination.visible = false
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	else:
		move_and_slide()
	run_velocity = velocity

func input_movement() -> Vector2:
	if coffee:
		input_direction = Input.get_vector("left", "right", "up", "down")
		var target_velocity = input_direction * speed * get_tile_data("tile_speed") * 1.5

		if input_direction != Vector2.ZERO:
			var target_speed = target_velocity.length()
			var current_speed = now_velocity.length()
			var new_speed = lerp(current_speed, target_speed, acceltration)

			var current_dir = now_velocity.normalized() if now_velocity != Vector2.ZERO else target_velocity.normalized()
			var target_dir = target_velocity.normalized()
			var new_dir = current_dir.slerp(target_dir, turn_accel)

			now_velocity = new_dir * new_speed
		else:
			now_velocity = now_velocity.slerp(Vector2.ZERO, friction)
		return now_velocity
	else :
		run_velocity = Vector2.ZERO
		if Input.get_vector("left", "right", "up", "down"):
			input_direction = Input.get_vector("left", "right", "up", "down")
		else:
			input_direction = Vector2.ZERO
		now_velocity = input_direction * speed * get_tile_data("tile_speed")
		return now_velocity

func put_destination(target):
	$destination.position = target
	$destination.visible = true
