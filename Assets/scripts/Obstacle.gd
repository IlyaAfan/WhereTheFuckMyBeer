extends StaticBody2D
class_name Obstacle

@export var is_passable = false as bool
var TileMap_I_Am_Standing_On: TileMapLayer
var cell: Vector2i
var cell_data: TileData

func on_parent_ready():
	TileMap_I_Am_Standing_On = get_parent()
	if TileMap_I_Am_Standing_On:
		print("yo")
		var pol = NavigationPolygon.new()
		cell = TileMap_I_Am_Standing_On.local_to_map(position)
		cell_data = TileMap_I_Am_Standing_On.get_cell_tile_data(cell)

func _ready() -> void:
	get_parent().connect("ready",on_parent_ready) 
