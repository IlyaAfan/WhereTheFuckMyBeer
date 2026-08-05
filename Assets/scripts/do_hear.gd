extends Node2D

signal WhatIsThat()
signal iFound(target: Character)
signal iLost(target: Character)

var target:Node2D
var hear = false
var found = false
var i: int

@export var grace_ticks: int = 0
@export var radius = 56

func _ready() -> void:
	$Area2D/CollisionShape2D.shape.radius = radius
	$destination.visible = false

func put_enemy_destination(dest):
	$destination.position = dest
	$destination.visible = true


func _on_timer_timeout() -> void:
	if hear:
		if !found:
			if i > 0:
				WhatIsThat.emit()
				i-=1
			else:
				found = true 
				iFound.emit(target)
		else: iFound.emit(target)
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		hear = true
		target = body
		i = grace_ticks
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == target:
		i = 0
		hear = true
		found = false 
		iLost.emit(target)
		put_enemy_destination(target.global_position)


func _on_destination_body_entered(body: Node2D) -> void:
	if $destination.visible and body.is_in_group("Enenemies"):
		$destination.visible = false
