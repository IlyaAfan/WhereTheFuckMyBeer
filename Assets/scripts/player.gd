extends Character

signal caught
var input_direction: Vector2
var navigated: bool
var name_item: String

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
	

func _physics_process(_delta: float) -> void:
	if preffer_nav_input:
		velocity = nav_movement()
		
		if Input.is_action_pressed("lmb"):
			Navigation_Agent_Used.target_position = get_global_mouse_position()
			navigated = true
		
		if Navigation_Agent_Used.is_navigation_finished():
			navigated = false
	else:
		velocity = input_movement()
	
	move_and_slide()


func input_movement() -> Vector2: 
	if Input.get_vector("left", "right", "up", "down"):
		input_direction = Input.get_vector("left", "right", "up", "down")
	else:
		input_direction = Vector2.ZERO
	return input_direction * speed * get_tile_data("tile_speed")
