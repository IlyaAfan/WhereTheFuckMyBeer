extends State
class_name Search

var last_seen_position: Vector2
var last_seen_velocity: Vector2

func enter():
	MyTiles = MyCharacter.TileMap_I_Am_Standing_On

	patience_left = patience_time
	if !do_see.is_connected("iFound", found):
		do_see.iFound.connect(found)
	if !do_see.is_connected("iHear", heard):
		do_see.iHear.connect(heard)
		
	last_seen_position = do_see.target.global_position
	last_seen_velocity = do_see.target.velocity
	should_look_at = do_see.rotation


func update(delta):

	if patience_left > 0:
		patience_left -= delta
	else:
		patience_left = patience_time
		var walkable_tiles = get_walkable_tiles_around(MyTiles.local_to_map(MyCharacter.position))
		var tile_to_look_at = Vector2(walkable_tiles[randi_range(0, len(walkable_tiles))-1])
		should_look_at = do_see.global_position.angle_to_point(MyCharacter.global_position + tile_to_look_at)
		
func physics_update(_delta):
	do_see.rotation = lerp_angle(do_see.rotation, should_look_at,MyCharacter.rotation_speed)

func heard():
	patience_left = patience_time

func found(_target):
	Transition.emit(self, "Chase")
