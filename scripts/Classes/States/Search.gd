extends State
class_name Search

var target_probable_position: Vector2
var target_velocity: Vector2

func enter():
	MyTiles = MyCharacter.TileMap_I_Am_Standing_On

	patience_left = patience_time
	if !do_see.is_connected("iFound", found):
		do_see.iFound.connect(found)
	if !do_see.is_connected("iHear", heard):
		do_see.iHear.connect(heard)
	
	target_probable_position = do_see.target_last_seen_position
	target_velocity = do_see.target_last_seen_velocity
	should_look_at = do_see.global_position.angle_to_point(do_see.target_last_seen_velocity)
	

func update(delta):
	if patience_left > 0:
		patience_left-= delta
		
	else:
		lost()

func physics_update(_delta):
	MyCharacter.velocity = target_velocity 
	do_see.rotation = lerp_angle(do_see.rotation, should_look_at, MyCharacter.rotation_speed)


func heard():
	patience_left = patience_time

func found(_target):
	Transition.emit(self, "Chase")

func lost():
	Transition.emit(self, "Idle")
