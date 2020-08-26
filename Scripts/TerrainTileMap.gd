extends TileMap


func paint_terrain_map(terrain):
	clear()
	var y_index = 0
	for row in terrain:
		var x_index = 0
		for column in row:
			set_cell(x_index, y_index, terrain[y_index][x_index])
			x_index += 1
		y_index += 1
