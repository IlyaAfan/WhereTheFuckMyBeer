extends Node2D

signal iFound(target: Character)

const Grace = 4 #grace-период в тиках таймера
#писюны
var target:Node2D
var target_last_seen_at: Vector2
var hear:bool = false
var see:bool = false
var navigated:bool = false # означает что враг прямо сейчас бежит на игрока, "наведён" на него
#ПЕРЕДЕЛАТЬ: используем дохуя булов чтобы обозначить состояния, нужна система состояний
var i = 0 as int
var GraceI = -1 as int #переменная для таймера grace периода

@export var nagent: NavigationAgent2D
@export var radius = 56
@export var AreaShape: Shape2D

func on_parent_ready():
	if get_parent().Navigation_Agent_Used and !nagent:
		nagent =get_parent().Navigation_Agent_Used
		
	$Area2D/CollisionShape2D.shape = AreaShape


func _ready() -> void:
	get_parent().connect("ready",on_parent_ready) 
	
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
		$RayCast2D.target_position = $RayCast2D.to_local(target.global_position)
		$RayCast2D.look_at(target.global_position)
		$RayCast2D.force_raycast_update()
		if !$RayCast2D.is_colliding(): 
		# Hear And See
			if navigated: #Смотрим нужен ли Grace-период, если он уже бежит за игроком, то период не нужен.
				iFound.emit(target)
				navigate()
			else: 
				if see:
					if i == GraceI:
						$Question.visible = false
						$Exclamation.visible = true
						$Exclamation2.visible = true
						iFound.emit(target)
						navigate()
				else:
					$Question.visible = true
					$Exclamation.visible = true
					$Exclamation2.visible = false
					see = true
					GraceI = (i + Grace)%10 # grace-период определяется здесь. I - тики таймера от 0 до 9
			
		# Hear No See
		else: 
			if navigated: 
			# Hear No See But Was Seen Earlier
				navigated = false
				target_last_seen_at = target.global_position
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
	if $destination.visible and body.is_in_group("Enemies"):
		$destination.visible = false
