extends State
class_name Search

var target_probable_position: Vector2
var target_velocity: Vector2
var target_addificator: Vector2
var my_direction: Vector2 # это куда мы собираемся идти по тайлам
var going_to_a_fork: bool = false

var paths: Array = []
var paths_old: Array
var turns: Array
var turns_old: Array

func enter():
	# Добавляем нужные для работы переменные и сигналы
	turns = []
	turns_old = []
	MyTiles = MyCharacter.TileMap_I_Am_Standing_On
	patience_left = patience_time	
	paths = get_walkable_tiles_around(MyTiles.local_to_map(MyCharacter.global_position))
	if !do_see.is_connected("iFound", found):
		do_see.iFound.connect(found)
	if !do_see.is_connected("iHear", heard):
		do_see.iHear.connect(heard)
	going_to_a_fork = false
	
	# Записываем послендние известные данные о цели, понимаем куда надо бежать
	target_velocity = do_see.target_last_seen_velocity
	target_probable_position = do_see.target_last_seen_position + target_velocity*0.1
	my_direction = get_lookable_direction(target_probable_position)
	
	
	# Здесь будут анимации, но пока что просто меняем спрайт
	var Sprite: Sprite2D = MyCharacter.find_child("testGoblin")
	Sprite.texture = sprite
	
	print(my_direction)



func update(delta):
	
	if patience_left > 0: # Усли терпение ещё есть -- ищем игрока
		patience_left-= delta
		
		#if !going_to_a_fork:
		MyCharacter.heard_a_call(MyCharacter.global_position + my_direction*Vector2(16,16))
		
		#Пока не упрёмся в стену -- запоминаем повороты.
		#if paths_old != paths:
			#if !turns.any(is_it_this_tile) and !turns_old.any(is_it_this_tile):
				#turns.append(MyTiles.local_to_map(MyCharacter.global_position))
		
		## Когда упрёмся -- идём к последней развилке
		if get_walkable_tiles_around(MyTiles.local_to_map(MyCharacter.global_position)).count(Vector2i(my_direction)) == 0:
			lost_interest()
			#go_to_next_fork()
		##Как дойдём до развилки -- выбираем новое направление и идём в него
		#if going_to_a_fork and MyCharacter.Navigation_Agent_Used.is_navigation_finished():
			#new_direction()
		#paths_old = paths
		#paths = get_walkable_tiles_around(MyTiles.local_to_map(MyCharacter.global_position))
		
	else: # Если кончается терпение -- идём в Idle
		lost_interest()


func physics_update(_delta):
	should_look_at = do_see.position.angle_to_point(get_lookable_direction(MyCharacter.Navigation_Agent_Used.target_position))
	do_see.rotation = lerp_angle(do_see.rotation, should_look_at, MyCharacter.rotation_speed)


func go_to_next_fork():
	print("go to a fork")
	if len(turns) > 0:
		going_to_a_fork = true
		var turn = turns.pop_back()
		print(turn)
		turns_old.append(turn)
		MyCharacter.heard_a_call(MyTiles.map_to_local(turn))
	else:
		lost_interest()

func new_direction():
	going_to_a_fork = false
	var walkable_tiles = get_walkable_tiles_around(MyTiles.local_to_map(MyCharacter.position))
	#walkable_tiles.erase(Vector2i(my_direction))
	if len(walkable_tiles):
		my_direction = Vector2(walkable_tiles[randi_range(0, len(walkable_tiles))-1])
	else:
		go_to_next_fork()

func is_it_this_tile(vector:Vector2i) -> bool:
	return vector == MyTiles.local_to_map(MyCharacter.global_position)



func heard(): # Если игрока было слышно -- обновляем терпение
	patience_left = patience_time

func found(_target):
	Transition.emit(self, "Chase")

func lost_interest():
	Transition.emit(self, "Idle")
