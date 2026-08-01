extends Node2D

@export var radius = 8
var body_last_seen: Character
var caught: bool = false

func _ready() -> void:
	caught = false
	$Area2D/CollisionShape2D.shape.radius = radius

func _on_area_2d_body_entered(body: Node2D) -> void:
	body_last_seen = body
	if body.is_in_group("Player") and body.not_catchable == false and !caught:
		body.get_caught()
		get_parent().speed = 0
		caught = true

func _on_timer_timeout() -> void:
	if body_last_seen and $Area2D.overlaps_body(body_last_seen):
		if body_last_seen.is_in_group("Player") and body_last_seen.not_catchable == false and !caught:
			body_last_seen.get_caught()
			get_parent().speed = 0
			caught = true
