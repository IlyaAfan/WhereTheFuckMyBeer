extends Character

@export var rotation_speed:float = 0.1
@export var patrol_points: Curve2D

@onready var do_see = $do_see

func _ready() -> void:
	Navigation_Agent_Used = $NavigationAgent2D
	TileMap_I_Am_Standing_On = get_tree().get_first_node_in_group("TileMap")
	add_to_group("Enemy")

func _physics_process(_delta: float) -> void:
	velocity = nav_movement()
	move_and_slide()
