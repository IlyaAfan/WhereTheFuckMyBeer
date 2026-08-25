extends Character

var rage: bool = false
var bobo: bool = false
var go_direction: Vector2

@export var SpriteCalm: Texture2D
@export var SpriteRage: Texture2D

@onready var BonkDetector: RayCast2D = $BonkDetector
func _ready() -> void:
	Navigation_Agent_Used = $NavigationAgent2D
	TileMap_I_Am_Standing_On = get_tree().get_first_node_in_group("TileMap")
	add_to_group("Enemy")
	$do_see.connect("iFound", noticed)

func _physics_process(delta: float) -> void:
	if rage:
		heard_a_call(global_position + go_direction*Vector2(16,16))
		if BonkDetector.is_colliding():
			bonked()
	velocity = nav_movement()
	move_and_slide()

func noticed(target: Character):
	if rage:
		return
	elif bobo:
		return
	
	var target_direction: Vector2 = get_lookable_direction(target.position)
	rage = true
	$TestOrc.texture = SpriteRage
	go_direction = target_direction
	
	BonkDetector.look_at(global_position + go_direction)
	BonkDetector.force_raycast_update()

func bonked():
	rage = false
	bobo = true
	$TestOrc.texture = SpriteCalm
	$TestOrc.scale.y = 0.75
	speed = 0
	$do_see.visible = false
	$do_catch.active = false
	
func recover():
	bobo = false
	$TestOrc.texture = SpriteCalm
	$TestOrc.scale.y = 1
	speed = save_speed
	$do_see.visible = true
	$do_catch.active = true
