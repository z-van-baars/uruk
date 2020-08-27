extends TileMap

var terrain = []

func load_map():
	terrain = get_tree().root.get_node("Main/WorldGen").terrain
	

func paint_terrain():
	clear()
	var y_index = 0
	for row in terrain:
		var x_index = 0
		for column in row:
			set_cell(x_index, y_index, terrain[y_index][x_index])
			x_index += 1
		y_index += 1
