extends Node2D

func toggle_pause():
	get_tree().paused = not get_tree().paused


func _ready():
	get_tree().paused = false

	if not $Player.is_connected("caught",_on_player_caught):
		$Player.caught.connect(_on_player_caught)

func _on_player_caught() -> void:
	$Camera2D/in_game_menu.toggle_menu($Camera2D/in_game_menu)
	$Camera2D/death_screen.toggle_menu($Camera2D/death_screen)
	toggle_pause()
