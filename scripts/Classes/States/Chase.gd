extends State
class_name Chase

var target: Character

func enter():
	patience_left = patience_time
	target = do_see.target
	if !do_see.is_connected("iHear", heard):
		do_see.iHear.connect(heard)
	
	# Здесь будут анимации, но пока что просто меняем спрайт
	var Sprite: Sprite2D = MyCharacter.find_child("testGoblin")
	Sprite.texture = sprite

func update(delta):
	if do_see.found:
		MyCharacter.heard_a_call(target)
		patience_left = patience_time
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
			lost()
		else:
			should_look_at = do_see.global_position.angle_to_point(do_see.target_last_seen_position)
	
	do_see.rotation = lerp_angle(do_see.rotation, should_look_at, MyCharacter.rotation_speed)


func heard(): # Если игрока было слышно -- обновляем терпение
	patience_left = patience_time

func lost():
	Transition.emit(self, "Search")
