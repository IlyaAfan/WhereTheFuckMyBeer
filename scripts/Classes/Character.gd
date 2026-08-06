extends CharacterBody2D
class_name Character

@export var Navigation_Agent_Used: NavigationAgent2D
@export var speed = 50 #стандартная скорость -- скорость игрока
var direction : Vector2
var TileMap_I_Am_Standing_On: TileMapLayer

func get_tile_data(data_name: String): # вернёт значение нужных данных для тайла на котором стоит персонаж, например tile_speed
	if not TileMap_I_Am_Standing_On:
		return 1
	
	var cell:= TileMap_I_Am_Standing_On.local_to_map(position)
	var data: TileData = TileMap_I_Am_Standing_On.get_cell_tile_data(cell)
	
	if data:
		return data.get_custom_data(data_name)
	return 1
	
func nav_movement() -> Vector2: # возвращает нужную скорость при движении используя навигацию, если у персонажа нет Navigation Agent вернёт нулевую скорость
	if not Navigation_Agent_Used:
		direction = Vector2.ZERO
	if not Navigation_Agent_Used.is_navigation_finished():
		direction = to_local(Navigation_Agent_Used.get_next_path_position()).normalized()
	else:
		direction = Vector2.ZERO
	return (direction * speed * get_tile_data("tile_speed"))

func stop_navigation():
	Navigation_Agent_Used.target_position = position

func heard_a_call(target): #должна вызываться когда кто-то извне дал наводку на игрока(например fart smella)
	if target is Vector2:
		Navigation_Agent_Used.target_position = target
	if target is Character:
		Navigation_Agent_Used.target_position = target.global_position

func connect_ears(emitter:Node2D, signl: String):#присоединяет метод выше к сигналу:
	if !emitter.is_connected(signl, heard_a_call):
		emitter.connect(signl, heard_a_call)
