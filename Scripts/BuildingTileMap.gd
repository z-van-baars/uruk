extends TileMap

var buildings = []

func load_map():
	buildings = get_tree().root.get_node("Main/WorldGen").buildings

func paint_buildings():
	clear()
	print(tile_set.get_tiles_ids())
	var y_index = 0
	for row in buildings:
		var x_index = 0
		for building in row:
			if building == null:
				x_index += 1
				continue
			else: 
				set_cellv(Vector2(x_index, y_index), buildings[y_index][x_index])
				x_index += 1
		y_index += 1
