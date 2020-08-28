extends Node2D
var pos = Vector2(0, 0)
var selected_tile
var build_mode = false
var zoning_mode = false

func _process(delta):
	if build_mode == false and zoning_mode == false:
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

func _on_toggle_zoning_mode():
	zoning_mode = !zoning_mode
	all_off()
	visible = !visible

func all_off():
	for each in $ZoneSprites.get_children():
		each.hide()


func set_zone(zone_type):
	all_off()
	if zone_type == 0:
		$ZoneSprites/Farmland.show()
	elif zone_type == 1:
		$ZoneSprites/Slums.show()
	elif zone_type == 2:
		$ZoneSprites/Artisan.show()
	elif zone_type == 3:
		$ZoneSprites/ArtisanHousing.show()
	elif zone_type == 4:
		$ZoneSprites/NobleHousing.show()
	elif zone_type == 6:
		$ZoneSprites/Dezone.show()
