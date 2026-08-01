extends Obstacle

func open():
	is_passable = true
	collision_layer = 0
	collision_mask = 0
	$Closed.visible = false
	TileMap_I_Am_Standing_On.set_cell(cell,0, Vector2i(0,!is_passable))
	
func close():
	is_passable = false
	collision_layer = 1
	collision_mask = 1
	$Closed.visible = true
	TileMap_I_Am_Standing_On.set_cell(cell,0, Vector2i(0,!is_passable))
	
func toggle():
	is_passable = !is_passable
	$CollisionShape2D.disabled = !$CollisionShape2D.disabled
	$Closed.visible = !$Closed.visible
	TileMap_I_Am_Standing_On.set_cell(cell,0, Vector2i(0,!is_passable))
