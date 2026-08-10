extends item

var clone: CharacterBody2D


func _process(_delta: float) -> void:
	located()
	use_item()


func _on_area_body_entered(body: Node2D) -> void:
	get_up(body)

func activate_item():
	ConfigOption.cats += 1
	active = true
	$TextureCats.visible = false

	# отвязываем клона от предмета, чтобы он не таскался вслед за игроком
	# вместе с самим предметом (located() двигает узел Cats))
	clone = $clone_player
	remove_child(clone)
	get_parent().add_child(clone)
	clone.global_position = $"../Player".global_position
	clone.visible = true
	clone.active = true
