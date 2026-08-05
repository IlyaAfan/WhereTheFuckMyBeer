extends Node2D


const SCENE_COFFEE = preload("res://tscns/Items/coffee.tscn")
const SCENE_PIPE = preload("res://tscns/Items/pipe.tscn")
const SCENE_CATS = preload("res://tscns/Items/cats).tscn")
const SCENE_BURGER = preload("res://tscns/Items/burger.tscn")
var new_item
var cooldawn = false
var rot_speed: int

var active = false
var ivent:int
var twist: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active and Input.is_action_just_pressed("use_item") and not cooldawn:
		_machine_random()
	if twist:
		rotation += 100 * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Button.visible = true
		$Label.visible = true
		active = true
	


func _on_button_pressed() -> void:
	if active and not cooldawn:
		_machine_random()
		
func _machine_random():
	ivent = randi_range(0,7)
	twist = true
	await get_tree().create_timer(3).timeout
	twist = false
	if ivent < 4:
		match ivent:
			0:
				new_item = SCENE_COFFEE.instantiate()
			1,3,2:
				new_item = SCENE_PIPE.instantiate()
			2:
				new_item = SCENE_CATS.instantiate()
			3:
				new_item = SCENE_BURGER.instantiate()
		new_item.position = $"../Player".position
		get_tree().current_scene.add_child(new_item)
	cooldawn = true
	await get_tree().create_timer(10).timeout
	cooldawn = false
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$Button.visible = false
		$Label.visible = false
		active = false
