extends Node

@export var default_state: State

var current_state: State
var states: Dictionary = {} 

func on_parent_ready(): #Первым входим в дефолтное состояние
	if default_state and states.has(default_state.name.to_lower()):
		default_state.enter()
		current_state = default_state

func _ready() -> void: 
	if get_parent():
		get_parent().ready.connect(on_parent_ready)
		
	for child in get_children(): #записываем детей и берём от них сигнал, даём им MyCharacter
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
	print(new_state_name)
	
	var new_state:State = states.get(new_state_name.to_lower())
	
	if !new_state: #если нового состояния не существует -- возвращаемся к дефолтному
		if default_state and states.has(default_state.name.to_lower()):
			default_state.enter()
			current_state = default_state
			return
	
	if current_state:
		current_state.exit()
	
	current_state = new_state
	new_state.enter()
