extends Node

class_name State

signal Transition(state_old: State,state_new_name: String)
@export var MyCharacter: Character

func enter():
	pass

func exit():
	pass

func update(delta:float) -> void:
	pass

func physics_update(delta:) -> void:
	pass
