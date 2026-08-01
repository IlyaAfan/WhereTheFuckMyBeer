extends Character

func _ready() -> void:
	Navigation_Agent_Used = $NavigationAgent2D
	TileMap_I_Am_Standing_On = get_tree().get_first_node_in_group("TileMap")
	add_to_group("Enemy")

func _physics_process(_delta: float) -> void:
	velocity = nav_movement()
	move_and_slide()


func heard_a_call(target: Vector2): #должна вызываться когда кто-то извне дал наводку на игрока(например fart smella)
	Navigation_Agent_Used.target_position = target

func connect_ears(emitter:Node2D, signl: String):#присоединяет метод выше к сигналу:
	emitter.connect(signl, heard_a_call)
