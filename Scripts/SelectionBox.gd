extends Node2D
var pos = Vector2(0, 0)
var selected_tile
var build_mode = false

func _process(delta):
	if build_mode == false:
		return
	pos = get_viewport().get_mouse_position()
	pos = get_viewport().get_canvas_transform().xform_inv(pos)
	
	var tile_map = get_tree().root.get_node("Main/WorldGen/TerrainTileMap")
	selected_tile = tile_map.world_to_map(pos)
	position = tile_map.map_to_world(selected_tile)

func _input(event):
	if event.is_action_pressed("left_click"):
		print(pos)
		print(selected_tile)

func get_selected_tile():
	return selected_tile


func _on_toggle_build_mode():
	build_mode = !build_mode
	visible = !visible
