extends CharacterBody2D

signal iHearADude(target: Vector2)
@export var Player: Node2D
@export var speed = 10
var direction : Vector2
var navigated = false

@onready var nagent = $NavigationAgent2D as NavigationAgent2D


func _physics_process(_delta: float) -> void:
	pass


func _on_do_hear(target: Vector2) -> void:
	iHearADude.emit(target)
