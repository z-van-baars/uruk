extends Node2D
onready var tools = get_tree().root.get_node("Main/Tools")
onready var tile_map = get_tree().root.get_node("Main/WorldGen/TerrainTileMap")
onready var selection_box = get_tree().root.get_node("Main/WorldGen/SelectionBox")
onready var build_cursor = get_tree().root.get_node("Main/BuildCursor")
var selected_tile
var pos

func _process(delta):
	position = get_viewport().get_mouse_position()
	pos = get_viewport().get_canvas_transform().xform_inv(position)
	selected_tile = tile_map.world_to_map(pos)
	$CursorSprites.modulate = Color.white
	$CostBox/CostLabel.modulate = Color.white
	if tools.is_blocked(selected_tile) == true:
		$CursorSprites.modulate = Color.maroon
		$CostBox/CostLabel.modulate = Color.red
	else:
		$CursorSprites.modulate = Color.limegreen
	selection_box.selected_tile = selected_tile
	build_cursor.selected_tile = selected_tile
	
func get_selected_tile():
	return selected_tile
