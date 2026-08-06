extends State
class_name Chase

var target: Character

func enter():
	#if !do_see.is_connected("iLost", lost):
		#do_see.iLost.connect(lost)
	patience_left = patience_time
	target = do_see.target

func update(delta):
	if do_see.found:
		MyCharacter.heard_a_call(target)
	else:
		patience_left -= delta
		lost()	
func physics_update(_delta):
	if do_see.found:
		do_see.rotation = lerp_angle(do_see.rotation, do_see.global_position.angle_to_point(target.global_position),MyCharacter.rotation_speed)
	else:
		do_see.rotation = lerp_angle(do_see.rotation, do_see.global_position.angle_to_point(do_see.target_last_seen_position),MyCharacter.rotation_speed)


func lost():
	if patience_left <= 0:
		Transition.emit(self, "Idle")
