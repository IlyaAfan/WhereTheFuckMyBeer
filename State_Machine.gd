extends Node

@export var start_state: State

var current_state: State
var states: Dictionary = {} 

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_state_transition)
	
	if start_state and states.has(start_state.name.to_lower()):
		start_state.enter()

func _process(delta: float) -> void:
	if current_state:
		current_state.update()


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update()


func on_state_transition(old_state: State, new_state_name: String) -> void:
	if old_state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if new_state:
		current_state = new_state
