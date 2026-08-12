extends Node2D

func toggle_pause():
	get_tree().paused = not get_tree().paused


func _ready():
	get_tree().paused = false

	if not $Player.is_connected("caught",_on_player_caught):
		$Player.caught.connect(_on_player_caught)

func _on_player_caught() -> void:
	find_child("death_screen").toggle_menu()
	find_child("in_game_menu").toggle_menu()
	toggle_pause()
