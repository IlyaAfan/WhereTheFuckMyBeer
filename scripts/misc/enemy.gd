extends Character

func _ready() -> void:
	Navigation_Agent_Used = $NavigationAgent2D
	TileMap_I_Am_Standing_On = get_tree().get_first_node_in_group("TileMap")
	add_to_group("Enemy")

func _physics_process(_delta: float) -> void:
	velocity = nav_movement()
	move_and_slide()
