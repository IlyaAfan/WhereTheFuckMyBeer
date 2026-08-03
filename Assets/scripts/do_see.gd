extends Node2D

signal iSee(target: Vector2)

const Grace = 4 #grace-период в тиках таймера
#писюны
var target:Node2D
var hear = false
var see = false
var navigated = false # означает что враг прямо сейчас бежит на игрока, "наведён" на него
#ПЕРЕДЕЛАТЬ: используем дохуя булов чтобы обозначить состояния, нужна система состояний
var i = 0 as int
var GraceI = -1 as int #переменная для таймера grace периода

@export var nagent: NavigationAgent2D
@export var radius = 56


func on_parent_ready():
	if get_parent().Navigation_Agent_Used:
		nagent =get_parent().Navigation_Agent_Used
	else:
		print("the parent has no Navigation_Agent_Used")


func _ready() -> void:
	get_parent().connect("ready",on_parent_ready) 
	
	$Area2D/CollisionShape2D.shape.radius = radius
	$RayCast2D.target_position = Vector2 (radius, 0)
	
	$destination.visible = false
	$Exclamation.visible = false
	$Exclamation2.visible = false
	$Question.visible = false

func put_enemy_destination():
	$destination.position = target.position
	$destination.visible = true

func navigate():
	if nagent:
		navigated = true
		nagent.target_position = target.global_position

func _on_timer_timeout() -> void: # С этой абоминацией надо будет разобраться получше
	
	if hear: 
		$RayCast2D.look_at(target.global_position)
		$RayCast2D.force_raycast_update()
		if $RayCast2D.is_colliding() and $RayCast2D.get_collider().name == ("Player"): 
		# Hear And See
			if navigated: #Смотрим нужен ли Grace-период, если он уже бежит за игроком, то период не нужен.
				iSee.emit(target.global_position)
				navigate()
			else: 
				if see:
					if i == GraceI:
						$Question.visible = false
						$Exclamation.visible = true
						$Exclamation2.visible = true
						iSee.emit(target.global_position)
						navigate()
				else:
					$Question.visible = true
					$Exclamation.visible = true
					$Exclamation2.visible = false
					see = true
					GraceI = (i + Grace)%10 # grace-период определяется здесь. I - тики таймера от 0 до 9
			
		else: 
		# Hear No See
			if navigated: 
			# Hear No See But Was Seen Earlier
				navigated = false
				put_enemy_destination()
			see = false
			$Exclamation.visible = false
			$Exclamation2.visible = false
			$Question.visible = true
	
	i+=1
	if i >= 10:
		#$AreaIndicator.visible = !$AreaIndicator.visible
		i = 0
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		hear = true
		target = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Question.visible = false
		$Exclamation.visible = false
		$Exclamation2.visible = false
		hear = false 
		see = false
		navigated = false

func _on_destination_hit(body: Node2D) -> void:
	if $destination.visible and body == get_parent():
		$destination.visible = false
