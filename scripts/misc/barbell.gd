extends item
var strong: bool = false
var stunned_enemies: Dictionary = {} # body -> исходная speed

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	located()
	use_item()
	check_area_attack() # добираем врагов, которые просто стоят в зоне

func check_area_attack() -> void:
	if strong:
		for body in $AreaAttack.get_overlapping_bodies():
			if body.is_in_group("Enemies") and not stunned_enemies.has(body):
				stun_enemy(body)

func stun_enemy(body: Node2D) -> void:
	stunned_enemies[body] = body.save_speed
	body.speed = 0
	await get_tree().create_timer(3).timeout #Время действия оглушения
	if stunned_enemies.has(body): # враг мог быть удалён/убит за это время
		body.speed = stunned_enemies[body]
		stunned_enemies.erase(body)

func _on_area_body_entered(body: Node2D) -> void:
	get_up(body)

func _on_area_2d_body_entered_attack(body: Node2D) -> void:
	if strong and body.is_in_group("Enemies") and not stunned_enemies.has(body):
		stun_enemy(body)

func activate_item():
	ConfigOption.barbell += 1
	active = true
	print("barbell")
	name_body.speed = 0
	await get_tree().create_timer(2.5).timeout
	strong = true
	visible = false
	name_body.not_catchable = true
	name_body.speed = name_body.save_speed

	await get_tree().create_timer(7).timeout
	strong = false

	while stunned_enemies.size() > 0:
		await get_tree().create_timer(0.1).timeout

	name_body.not_catchable = false
	active = false
