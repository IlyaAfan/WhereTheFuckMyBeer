extends Character

@export var rotation_speed:float = 0.1

func _ready() -> void:
	Navigation_Agent_Used = $NavigationAgent2D
	TileMap_I_Am_Standing_On = get_tree().get_first_node_in_group("TileMap")
	add_to_group("Enemy")

func _physics_process(_delta: float) -> void:
	velocity = nav_movement()
	if $do_see.hear:
		$do_see.rotation = lerp_angle($do_see.rotation, global_position.angle_to_point($do_see.target.position)-PI/2,rotation_speed)
		
	
	move_and_slide()
