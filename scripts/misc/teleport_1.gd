extends Node2D

var cooldawn = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if cooldawn == false:
		body.position = $"../teleport2".position
	cooldawn = !cooldawn
