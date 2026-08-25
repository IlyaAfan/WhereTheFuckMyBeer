extends Node

class_name State

signal Transition(state_old: State,state_new_name: String)
@export var MyCharacter: Character
@export var do_see: Node2D
@export var patience_time: float
@export var sprite: Texture2D

var patience_left: float

var MyTiles: TileMapLayer
var should_look_at: float

func enter():
	pass 

func exit():
	pass

func update(_delta:float) -> void:
	pass

func physics_update(_delta:float) -> void:
	pass
