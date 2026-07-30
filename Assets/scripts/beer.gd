extends StaticBody2D

@export var where_to : String

func _on_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file.bind(where_to).call_deferred()
