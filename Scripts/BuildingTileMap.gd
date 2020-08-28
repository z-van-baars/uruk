extends TileMap

var building_map

func load_map():
	building_map = get_tree().root.get_node("Main/WorldGen").building_map

func paint_buildings():
	clear()
	print(tile_set.get_tiles_ids())
	var y_index = 0
	for row in building_map:
		var x_index = 0
		for building in row:
			if building == null:
				x_index += 1
				continue
			else:
				set_cellv(Vector2(x_index, y_index), building_map[y_index][x_index])
				x_index += 1
		y_index += 1
