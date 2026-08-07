extends Node2D

@export var animation_tree: AnimationTree;
@onready var player : Character = get_owner();

	
var last_face_dir := Vector2(0,-1);
func _physics_process(delta: float) -> void:
	var idle = !player.velocity
	
	if !idle:
		last_face_dir = player.velocity.normalized()
	
	animation_tree.set("parameters/conditions/idle",idle)
	animation_tree.set("parameters/conditions/run",!idle)
	
	animation_tree.set("parameters/RUN/blend_position",last_face_dir)
	animation_tree.set("parameters/IDLE/blend_position",last_face_dir)
