extends Character

signal caught
var input_direction: Vector2
var navigated: bool
var name_item: String = "empty"
var not_catchable: bool

@export var preffer_nav_input = false as bool

func get_caught():
	caught.emit()
	speed = 0

func get_tile_data(data_name: String):
	var tile_map: TileMapLayer = get_tree().get_first_node_in_group("TileMap")
	if not tile_map:
		return 1
	
	var cell:= tile_map.local_to_map(position)
	var data: TileData = tile_map.get_cell_tile_data(cell)
	
	if data:
		return data.get_custom_data(data_name)
	return 1


func _ready():
	add_to_group("Player")
	navigated = false
	Navigation_Agent_Used = $NavigationAgent2D
	$destination.visible = false

func _physics_process(_delta: float) -> void:
	if preffer_nav_input:
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
		preffer_nav_input = !preffer_nav_input
		print(preffer_nav_input)
		
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
