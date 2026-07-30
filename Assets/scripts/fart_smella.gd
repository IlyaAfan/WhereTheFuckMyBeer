extends Character

signal iHearADude(target: Vector2)

@onready var nagent = $NavigationAgent2D as NavigationAgent2D


func _physics_process(_delta: float) -> void:
	pass


func _on_do_hear(target: Vector2) -> void:
	iHearADude.emit(target)
