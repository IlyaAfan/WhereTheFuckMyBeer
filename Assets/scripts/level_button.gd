extends Button

@export var whereto : String

func _on_pressed() -> void:
	get_tree().change_scene_to_file.bind(whereto).call_deferred()
