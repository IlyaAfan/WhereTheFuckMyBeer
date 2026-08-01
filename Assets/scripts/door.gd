extends Obstacle

func open():
	is_passable = true
	$CollisionShape2D.disabled = true
	$Closed.visible = false
	TileMap_I_Am_Standing_On.set_cell(cell,0, Vector2i(0,!is_passable))
	
func close():
	is_passable = false
	$CollisionShape2D.disabled = false
	$Closed.visible = true
	TileMap_I_Am_Standing_On.set_cell(cell,0, Vector2i(0,!is_passable))
	
func toggle():
	is_passable = !is_passable
	$CollisionShape2D.disabled = !$CollisionShape2D.disabled
	$Closed.visible = !$Closed.visible
	TileMap_I_Am_Standing_On.set_cell(cell,0, Vector2i(0,!is_passable))
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("use_item"):
		toggle()
