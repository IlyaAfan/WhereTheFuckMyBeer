extends TileMapLayer

var obstacles: Array
var n:= 0
var pol: NavigationPolygon

func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	if obstacles:
		if !pol:
			pol = get_cell_tile_data(obstacles[0].cell).get_navigation_polygon(0)
			
		for i in obstacles:
			if coords == i.cell:
				return true
	return false



func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData):
	for i in obstacles:
		if i.cell == coords:
			print(i.is_passable)
			if i.is_passable:
				print("I tried to at least")
				tile_data.set_navigation_polygon(0, pol)
			else:
				print("i did make it!")
				tile_data.set_navigation_polygon(0,null)

func _ready() -> void:
	if get_children():
		obstacles = get_children()
