extends Sprite2D

@onready var question:Sprite2D = $Question
@onready var exclamation:Sprite2D = $Exclamation
@onready var exclamation2:Sprite2D = $Exclamation2


func _on_do_see_what_is_that():
	print("whatisthat")
	question.visible = true
	exclamation.visible = true
	exclamation2.visible = false


func _on_do_see_i_cant_hear():
	print("cant hear")
	question.visible = false
	exclamation.visible = false
	exclamation2.visible = false



func _on_do_see_i_found(target):
	print("found")
	question.visible = false
	exclamation.visible = true
	exclamation2.visible = true


func _on_do_see_i_hear():
	print("hear")
	question.visible = true
	exclamation.visible = false
	exclamation2.visible = false


func _on_do_see_i_lost(target):
	print("lost")
	question.visible = true
	exclamation.visible = false
	exclamation2.visible = false
	$destination.put_enemy_destination(target.global_position)
