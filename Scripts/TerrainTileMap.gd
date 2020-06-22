extends TileMap


func paint_terrain_map(terrain):
	clear()
	print(tile_set.get_tiles_ids())
	var y_index = 0
	for row in terrain:
		var x_index = 0
		for column in row:
			print(x_index, ", ", y_index)
			print("setting " + str(terrain[y_index][x_index]))
			set_cell(x_index, y_index, terrain[y_index][x_index])
			x_index += 1
		y_index += 1
