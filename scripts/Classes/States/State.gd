extends Node

class_name State

signal Transition(state_old: State,state_new_name: String)
@export var MyCharacter: Character
@export var do_see: Node2D
@export var patience_time: float
@export var sprite: Texture2D

var patience_left: float

var MyTiles: TileMapLayer
var should_look_at: float

func enter():
	pass 

func exit():
	pass

func update(_delta:float) -> void:
	pass

func physics_update(_delta:float) -> void:
	pass


func get_walkable_tiles_around(position: Vector2i) -> Array:
	var result: Array = []
	#4 векторов обозначающих клетки вокруг
	var positions_around_me = [
		Vector2i(0,1),
		Vector2i(1,0),
		Vector2i(0,-1),
		Vector2i(-1,0)
		]
	for v:Vector2i in positions_around_me:
		if MyTiles.get_cell_tile_data(position + v).get_custom_data("tile_speed") > 0:
			result.append(v)
	return result

func get_lookable_direction(direction: Vector2, pos:Vector2i = MyTiles.local_to_map(MyCharacter.global_position)) -> Vector2:
	direction = direction - MyCharacter.global_position
	var walkable = get_walkable_tiles_around(pos)
	var res: Vector2 = walkable[0]
	var max_dot = -INF
	
	for dir in walkable:
		var normalized_wanted= direction.normalized()
		var normalized_dir  = Vector2(dir).normalized()
		var dot = normalized_dir.dot(normalized_wanted)
		if dot > max_dot:
			max_dot = dot
			res = dir
	return res
