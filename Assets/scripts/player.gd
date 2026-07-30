extends CharacterBody2D

signal caught
var input_direction: Vector2
@export var speed = 50
var name_item = "empty"

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

func _physics_process(_delta: float) -> void:
	if Input.get_vector("left", "right", "up", "down"):
		input_direction = Input.get_vector("left", "right", "up", "down")
	else:
		input_direction = Vector2.ZERO
	velocity = input_direction * speed * get_tile_data("tile_speed")

	move_and_slide()
	
	if Input.is_action_just_pressed("use_item") and name_item != "empty":
		match name_item:
			"coffee":
				$"../Coffee"._use_coffee($".")
			"pipe":
				$"../Pipe"._use_pipe()
		name_item = "empty"
