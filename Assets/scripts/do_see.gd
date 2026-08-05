extends Node2D

signal WhatIsThat()
signal iHear()
signal iCantHear()
signal iFound(target: Character)
signal iLost(target: Character)


var target:Character
var target_last_seen_at: Vector2
var hear:bool = false
var found:bool = false

var i = 0 as int 
@export var RayCast: RayCast2D 
@export var grace_ticks:int = 3
@export var radius = 56
@export var AreaShape: Shape2D

func on_parent_ready():
	$Area2D/CollisionShape2D.shape = AreaShape


func _ready() -> void:
	get_parent().connect("ready",on_parent_ready) 
	
	RayCast.target_position = Vector2 (radius, 0)
	$destination.visible = false

func put_enemy_destination(dest:Vector2):
	$destination.position = dest
	$destination.visible = true

func _on_timer_timeout() -> void:
	
	if hear:
		#Hear
		RayCast.target_position = target.position
		if !RayCast.is_colliding():
			#See
			if !found:
				if i > 0:
					i-=1
				else:
					found = true 
					iFound.emit(target)
			else: iFound.emit(target)
		elif found:
			#Seen earlier, but lost
			iLost.emit()
			found = false
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		hear = true
		target = body
		iHear.emit()
		i = grace_ticks
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == target:
		i = 0
		hear = false 
		found = false

func _on_destination_hit(body: Node2D) -> void:
	if $destination.visible and body.is_in_group("Enemies"):
		$destination.visible = false
