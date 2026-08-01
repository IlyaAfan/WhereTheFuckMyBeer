extends Character

signal caught
var input_direction: Vector2
var navigated: bool
var name_item: String = "empty"
var not_catchable: bool

func get_caught():
	caught.emit()
	speed = 0


func _ready():
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
		ConfigOption.type_control = not ConfigOption.type_control
		$destination.visible = false
	
	move_and_slide()
	use_item()


func input_movement() -> Vector2: 
	if Input.get_vector("left", "right", "up", "down"):
		input_direction = Input.get_vector("left", "right", "up", "down")
	else:
		input_direction = Vector2.ZERO
	return input_direction * speed * get_tile_data("tile_speed")

func put_destination(target):
	$destination.position = target
	$destination.visible = true

func use_item():
	if Input.is_action_just_pressed("use_item") and name_item != "empty":
		match name_item:
			"coffee":
				$"../Coffee"._use_coffee($".")
				name_item = "empty"
			"pipe":
				$"../Pipe"._use_pipe()
				name_item = "empty"
			"cats":
				$"../Cats)"._use_cats()
				name_item = "empty"
			"burger":
				$"../Burger"._use_burger($".")
				name_item = "empty"
			"barbell":
				$"../Barbell"._use_barbell()
				name_item = "empty"
		name_item = "empty"
