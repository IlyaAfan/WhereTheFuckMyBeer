extends Popup

var active = false
var ivent:int
var twist: bool
var idle = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = "Баланc золота: " + str(ConfigOption.gold)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active and Input.is_action_just_pressed("use_item"):
		_machine_random()
	if twist:
		$Kazino.rotation += 8*PI * delta
	else:
		$Kazino.rotation = 0
		
func _on_button_pressed() -> void:
	_machine_random()
		
func _machine_random():
	ConfigOption.load_game_stat()
	ConfigOption.gold -= 1
	ConfigOption.save_game_stat()
	$Label.text = "Баланс золота: " + str(ConfigOption.gold)
	ivent = randi_range(0,7)
	twist = true
	await get_tree().create_timer(2.98).timeout
	print($Kazino.rotation/PI)
	twist = false
	active = true


func _on_button_pressed_not_open() -> void:
	$".".visible = false
	$"../../Player".speed = 60
