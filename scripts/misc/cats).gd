extends Node2D

var have = false
var activated = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if have == true and not activated:
		position = $"../Player".position + Vector2(0,-7)
	


func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.name_item == "empty":
		body.name_item = "cats"
		have = true
		$Area.collision_layer = 0
		$Area.collision_mask = 0
		
func _use_cats():
	$TextureCats.visible = false
	activated = true
	$clone_player.visible = true
	$clone_player.global_position = $"../Player".global_position
