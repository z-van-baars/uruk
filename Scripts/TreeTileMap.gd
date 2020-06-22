extends TileMap


func paint_tree_map(trees, rocks):
	clear()
	print(tile_set.get_tiles_ids())
	var y_index = 0
	for row in trees:
		var x_index = 0
		for column in row:
			if trees[y_index][x_index] == 1:
				set_cell(x_index, y_index, 0)
			if rocks[y_index][x_index] == 1:
				set_cell(x_index, y_index, 1)
			x_index += 1
		y_index += 1
