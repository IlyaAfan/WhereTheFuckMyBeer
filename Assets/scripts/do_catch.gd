extends Node2D

@export var radius = 8
var body_last_seen: Character

func _ready() -> void:
	$Area2D/CollisionShape2D.shape.radius = radius

func _on_area_2d_body_entered(body: Node2D) -> void:
	body_last_seen = body
	if body.is_in_group("Player") and body.not_catchable == false:
		body.get_caught()


func _on_timer_timeout() -> void:
	if body_last_seen and $Area2D.overlaps_body(body_last_seen):
		if body_last_seen.is_in_group("Player") and body_last_seen.not_catchable == false:
			body_last_seen.get_caught()
