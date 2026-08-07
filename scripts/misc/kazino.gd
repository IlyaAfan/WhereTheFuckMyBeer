extends Node2D


const SCENE_COFFEE = preload("res://tscns/Items/coffee.tscn")
const SCENE_PIPE = preload("res://tscns/Items/pipe.tscn")
const SCENE_CATS = preload("res://tscns/Items/cats).tscn")
const SCENE_BURGER = preload("res://tscns/Items/burger.tscn")
var new_item

var reach = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if reach and Input.is_action_just_pressed("use_item"):
		$WindowKazino.visible = true
		$"../Player".speed = 0
	random_ivent()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		reach = true
	
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		reach = false

func random_ivent():
	if $WindowKazino.ivent < 4 and $WindowKazino.active:
		match $WindowKazino.ivent:
			0:
				new_item = SCENE_COFFEE.instantiate()
			1:
				new_item = SCENE_PIPE.instantiate()
			2:
				new_item = SCENE_CATS.instantiate()
			3:
				new_item = SCENE_BURGER.instantiate()
		new_item.position = $"../Player".position
		get_tree().current_scene.add_child(new_item)
		$WindowKazino.active = false
	
