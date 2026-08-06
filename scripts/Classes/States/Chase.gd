extends State
class_name Chase

var target: Character

func enter():
	patience_left = patience_time
	target = do_see.target

func update(delta):
	if do_see.found:
		MyCharacter.heard_a_call(target)
	else:
		MyCharacter.heard_a_call(do_see.target_last_seen_position)
		patience_left -= delta
		if patience_left <= 0:
			lost()

func physics_update(delta):
	if do_see.found:
		should_look_at = do_see.global_position.angle_to_point(target.global_position)
	else:
		if MyCharacter.Navigation_Agent_Used.is_navigation_finished():
			should_look_at = do_see.global_position.angle_to_point(do_see.target_last_seen_velocity)
		else:
			should_look_at = do_see.global_position.angle_to_point(do_see.target_last_seen_position)
	
	do_see.rotation = lerp_angle(do_see.rotation, should_look_at, MyCharacter.rotation_speed)


func lost():
	Transition.emit(self, "Search")
