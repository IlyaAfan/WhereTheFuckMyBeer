extends StaticBody2D
class_name Obstacle

var is_passable = false as bool
var TileMap_I_Am_Standing_On: TileMapLayer
var cell: Vector2i

func _ready() -> void:
	TileMap_I_Am_Standing_On = get_tree().get_first_node_in_group("TileMap")
	cell = TileMap_I_Am_Standing_On.local_to_map(position)
	TileMap_I_Am_Standing_On.set_cell(cell,0, Vector2i(0,!is_passable))
