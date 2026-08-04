extends Node2D

signal iHear(target: Vector2)

var target:Node2D
var found = false
var navigated = false

@export var nagent: NavigationAgent2D
@export var radius = 56

func on_parent_ready():
	if get_parent().Navigation_Agent_Used and !nagent:
		nagent =get_parent().Navigation_Agent_Used


func _ready() -> void:
	get_parent().connect("ready",on_parent_ready) 
	$Exclamation.visible = false
	$Area2D/CollisionShape2D.shape.radius = radius
	$destination.visible = false

func put_enemy_destination(dest):
	$destination.position = dest
	$destination.visible = true

func navigate():
	$destination.visible = false
	navigated = true
	nagent.target_position = target.global_position

func _on_timer_timeout() -> void:
	if found:
		$Exclamation.visible = true
		iHear.emit(target.global_position)
		navigate()
	else:
		if navigated:
			navigated = false
			put_enemy_destination(nagent.target_position)
		$Exclamation.visible = false
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		found = true
		target = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		found = false 


func _on_destination_body_entered(body: Node2D) -> void:
	if body.name.begins_with("Enemy"):
		$destination.visible = false
