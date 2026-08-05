extends Node

@export var start_state: State

var current_state: State
var states: Dictionary = {} 

func on_parent_ready():
	if start_state and states.has(start_state.name.to_lower()):
		start_state.enter()
		current_state = start_state

func _ready() -> void:
	if get_parent():
		get_parent().ready.connect(on_parent_ready)
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(on_state_transition)
			child.MyCharacter = get_parent()

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func on_state_transition(old_state: State, new_state_name: String) -> void:
	if old_state != current_state:
		return
	
	var new_state:State = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.exit()
	current_state = new_state
	new_state.enter()
