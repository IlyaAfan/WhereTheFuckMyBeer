extends State
class_name Idle_State

@export var patrol: bool = false
@export var do_see: Node

func enter():
	pass

func exit():
	pass

func update():
	if do_see:
		do_see.c
