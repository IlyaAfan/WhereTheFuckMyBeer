extends Obstacle

func open():
	is_passable = true
	collision_layer = 0
	collision_mask = 0
	$Closed.visible = false
	await get_tree().process_frame 
	get_parent().notify_runtime_tile_data_update()
	get_parent().update_internals()
	pass
	
func close():
	is_passable = false
	collision_layer = 1
	collision_mask = 1
	$Closed.visible = true
	await get_tree().process_frame 
	get_parent().notify_runtime_tile_data_update()
	get_parent().update_internals()

func toggle():
	is_passable = !is_passable
	$CollisionShape2D.disabled = !$CollisionShape2D.disabled
	$Closed.visible = !$Closed.visible
