extends Character

signal iHearADude(target: Vector2)

@onready var nagent = $NavigationAgent2D as NavigationAgent2D


func _physics_process(_delta: float) -> void:
	velocity = nav_movement()
	move_and_slide()
