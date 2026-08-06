extends Node

class_name State

signal Transition(state_old: State,state_new_name: String)
@export var MyCharacter: Character
@export var do_see: Node2D
@export var patience_time: float
var patience_left: float

var MyTiles: TileMapLayer
var should_look_at: float

func enter():
	pass 

func exit():
	pass

func update(_delta:float) -> void:
	pass

func physics_update(_delta:) -> void:
	pass


func get_walkable_tiles_around(position: Vector2i) -> Array:
	var result: Array = []
	#8 векторов обозначающих клетки вокруг
	var positions_around_me = [
		Vector2i(0,1),
		Vector2i(1,1),
		Vector2i(1,0),
		Vector2i(1,-1),
		Vector2i(0,-1),
		Vector2i(-1,-1),
		Vector2i(-1,0),
		Vector2i(-1,1),
		]
	for v:Vector2i in positions_around_me:
		if MyTiles.get_cell_tile_data(position + v).get_custom_data("tile_speed") > 0:
			result.append(v)
	return result
