extends Sprite2D

@onready var question:Sprite2D = $Question
@onready var exclamation:Sprite2D = $Exclamation
@onready var exclamation2:Sprite2D = $Exclamation2


func _on_do_see_what_is_that():
	question.visible = true
	exclamation.visible = true
	exclamation2.visible = false


func _on_do_see_i_cant_hear():
	question.visible = false
	exclamation.visible = false
	exclamation2.visible = false



func _on_do_see_i_found(_target):
	question.visible = false
	exclamation.visible = true
	exclamation2.visible = true


func _on_do_see_i_hear():
	question.visible = true
	exclamation.visible = false
	exclamation2.visible = false


func _on_do_see_i_lost(target):
	question.visible = true
	exclamation.visible = false
	exclamation2.visible = false
