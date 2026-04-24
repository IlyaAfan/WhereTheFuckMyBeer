extends CharacterBody2D

@export var Player: Node2D
@export var speed = 60
var direction : Vector2

@onready var nagent = $NavigationAgent2D as NavigationAgent2D

func _physics_process(_delta: float) -> void:
	nav_movement()
	move_and_slide()

func nav_movement():
	if not nagent.is_navigation_finished():
		direction = to_local(nagent.get_next_path_position()).normalized()
	else:
		direction = Vector2.ZERO
	velocity = direction * speed * get_tile_data("tile_speed")

func heard_a_call(target: Vector2): #должна вызываться когда кто-то извне дал наводку на игрока(например fart smella)
	nagent.target_position = target

func connect_ears(emitter:Node2D, signl: String):#присоединяет метод выше к сигналу:
	emitter.connect(signl, heard_a_call)

func get_tile_data(data_name: String):
	var tile_map: TileMapLayer = get_tree().get_first_node_in_group("TileMap")
	if not tile_map:
		return 1
	
	var cell:= tile_map.local_to_map(position)
	var data: TileData = tile_map.get_cell_tile_data(cell)
	
	if data:
		return data.get_custom_data(data_name)
	return 1
