extends Node2D
onready var tools = get_tree().root.get_node("Main/Tools")
onready var tile_map = get_tree().root.get_node("Main/WorldGen/TerrainTileMap")
onready var player = get_tree().root.get_node("Main/Player")

var selected_tile = Vector2.ZERO
var build_mode = false

func _process(delta):
	if player.build_mode == false:
		hide()
		return
	show()
	position = tile_map.map_to_world(selected_tile)
	modulate = Color.white
	if tools.is_blocked(selected_tile) == true:
		modulate = Color.maroon
	else:
		modulate = Color.limegreen

