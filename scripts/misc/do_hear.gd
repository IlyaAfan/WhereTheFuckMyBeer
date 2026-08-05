extends Node2D

signal WhatIsThat()
signal iFound(target: Vector2)
signal iLost(target: Character)

var target:Node2D
var hear = false
var found = false
var i: int

@export var grace_ticks: int = 0
@export var radius = 56

func on_parent_ready():
	get_parent().connect_ears(self, "iFound")


func _ready() -> void:
	get_parent().connect("ready",on_parent_ready) 
	$Area2D/CollisionShape2D.shape.radius = radius


func _on_timer_timeout() -> void:
	if hear:
		if !found:
			if i > 0:
				WhatIsThat.emit()
				i-=1
			else:
				found = true 
				iFound.emit(target.global_position)
		else: iFound.emit(target.global_position)
	

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
