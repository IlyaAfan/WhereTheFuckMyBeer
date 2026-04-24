extends Node2D

signal iSee(target: Vector2)

var target:Node2D
var hear = false
var see = false
var navigated = false
#ПЕРЕДЕЛАТЬ: используем дохуя булов чтобы обозначить состояния, нужна система состояний
var i = 0 as int
@export var nagent: NavigationAgent2D
@export var radius = 56

func _ready() -> void:
	$Area2D/CollisionShape2D.shape.radius = radius
	$RayCast2D.target_position = Vector2 (radius, 0)
	
	$destination.visible = false
	$Exclamation.visible = false
	$Question.visible = false

func put_enemy_destination():
	$destination.position = target.position
	$destination.visible = true

func navigate():
	see = true
	navigated = true
	nagent.target_position = target.global_position

func _on_timer_timeout() -> void:
	if hear:
		$RayCast2D.look_at(target.global_position)
		$RayCast2D.force_raycast_update()
		if $RayCast2D.is_colliding() and $RayCast2D.get_collider().name == ("Player"): 
		# Hear And See
			
			$Question.visible = false
			$Exclamation.visible = true
			
			iSee.emit(target.global_position)
			navigate()
		else: 
		# Hear No See
			if navigated: 
			# Hear No See But Was Seen Earlier
				navigated = false
				put_enemy_destination()
			see = false
			$Exclamation.visible = false
			$Question.visible = true
	
	i+=1
	if i >= 10:
		$AreaIndicator.visible = !$AreaIndicator.visible
		i = 0
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		hear = true
		target = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Question.visible = false
		$Exclamation.visible = false
		hear = false 
		see = false
		navigated = false

func _on_destination_hit(body: Node2D) -> void:
	if $destination.visible and body == get_parent():
		$destination.visible = false
