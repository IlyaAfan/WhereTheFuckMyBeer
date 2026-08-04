extends Node2D

signal iHearADude(target: Vector2)

@export var nagent: NavigationAgent2D

func on_parent_ready():
	if get_parent().Navigation_Agent_Used and !nagent:
		nagent =get_parent().Navigation_Agent_Used
		
	if nagent:
		nagent.path_changed.connect(on_navigated)

func _ready() -> void:
	get_parent().connect("ready",on_parent_ready) 

func on_navigated():
	iHearADude.emit(nagent.target_position)
