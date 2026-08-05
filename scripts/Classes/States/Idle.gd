extends State
class_name Idle

@export var patrol: bool = false
@export var do_see: Node2D
@export var patience_time: float
var patience_left: float

var MyTiles: TileMapLayer
var position_tiles: Vector2i
var walkable_tiles: Array
var should_look_at: Vector2

func enter():
	patience_left = patience_time
	MyTiles = MyCharacter.TileMap_I_Am_Standing_On
	
	
	position_tiles = MyTiles.local_to_map(MyCharacter.position)
	walkable_tiles = get_walkable_tiles_around()
	
func exit():
	pass

func update(delta):
	if patience_left > 0:
		patience_left -= delta
	else:
		patience_left = patience_time
		var tile_to_look_at = Vector2(walkable_tiles[randi_range(0, len(walkable_tiles))-1])
		should_look_at = MyCharacter.global_position + tile_to_look_at 
		
func physics_update(_delta):
	do_see.rotation = lerp_angle(do_see.rotation, do_see.global_position.angle_to_point(should_look_at),MyCharacter.rotation_speed)

func get_walkable_tiles_around() -> Array:
	var result: Array = []
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
		if MyTiles.get_cell_tile_data(position_tiles + v).get_custom_data("tile_speed") > 0:
			result.append(v)
	return result
	
func Char_Saw:
