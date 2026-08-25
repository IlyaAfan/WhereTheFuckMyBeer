extends State
class_name Idle

@export var patrol: bool = false
@export var patrol_points: Array
var start_transform: Transform2D
var start_position: Vector2i
var i: int = 0

func enter():
	MyTiles = MyCharacter.TileMap_I_Am_Standing_On
	patrol = MyCharacter.patrol
	
	#setting start position data
	if !start_transform:
		start_transform = MyCharacter.transform
		start_position = MyTiles.local_to_map(MyCharacter.global_position)
		
	#setting up patrol points
	if len(MyCharacter.patrol_points) > 0:
		patrol = true
		patrol_points = MyCharacter.patrol_points
		MyCharacter.heard_a_call(MyTiles.map_to_local(patrol_points[i%len(patrol_points)]))
	elif patrol:
		patrol_points.append(start_position)
	
	#setting other bs
	patience_left = patience_time
	if !do_see.is_connected("iFound", found):
		do_see.iFound.connect(found)
	if !MyCharacter.Navigation_Agent_Used.is_connected("navigation_finished", patrol_end_):
		MyCharacter.Navigation_Agent_Used.navigation_finished.connect(patrol_end_)
	var Sprite: Sprite2D = MyCharacter.find_child("testGoblin")
	Sprite.texture = sprite
	
	look_at_next_tile_()
	MyCharacter.heard_a_call(MyCharacter.global_position)


func update(delta):
	if do_see.hear:
		heard()
	
	if patience_left > 0:
		patience_left -= delta
	else:
		patience_left = patience_time
		if !MyCharacter.Navigation_Agent_Used.is_navigation_finished():
			return
		
		if patrol:
			patrol_func_()
		else:
			look_at_next_tile_()


func physics_update(_delta):
	if patrol:
		if !MyCharacter.Navigation_Agent_Used.is_navigation_finished():
			should_look_at = do_see.position.angle_to_point(MyCharacter.get_lookable_direction(MyCharacter.Navigation_Agent_Used.target_position))
			
	do_see.rotation = lerp_angle(do_see.rotation, should_look_at,MyCharacter.rotation_speed)

func look_at_next_tile_():
		var walkable_tiles = MyCharacter.get_walkable_tiles_around(MyTiles.local_to_map(MyCharacter.position))
		var tile_to_look_at = Vector2(walkable_tiles[randi_range(0, len(walkable_tiles))-1])
		should_look_at = do_see.global_position.angle_to_point(MyCharacter.global_position + tile_to_look_at)

func patrol_func_():
	if patrol_points != []:
		MyCharacter.heard_a_call(MyTiles.map_to_local(patrol_points[i%len(patrol_points)]))
		i += 1
	else:
		MyCharacter.heard_a_call(MyTiles.map_to_local(start_position))

func patrol_end_():
	var rotated_one = Vector2.ONE.from_angle(start_transform.get_rotation()-PI)
	should_look_at = do_see.position.angle_to_point(MyCharacter.get_lookable_direction(rotated_one))

func heard():
	patience_left = patience_time

func found(_target):
	Transition.emit(self, "Chase")
