extends Obstacle

func open():
	is_passable = true
	$CollisionShape2D.disabled = true
	$Closed.visible = false

func close():
	is_passable = false
	$CollisionShape2D.disabled = false
	$Closed.visible = true

func toggle():
	is_passable = !is_passable
	$CollisionShape2D.disabled = !$CollisionShape2D.disabled
	$Closed.visible = !$Closed.visible
	
func _ready():
	toggle()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("use_item"):
		toggle()
	
