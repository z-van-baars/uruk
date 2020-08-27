extends TileMap

var zones = []

func load_map():
	zones = get_tree().root.get_node("Main/WorldGen").zones
	
func paint_zones():
	clear()
	var y_index = 0
	for row in zones:
		var x_index = 0
		for zone in row:
			if zone == null:
				x_index += 1
				continue
			else:
				set_cellv(Vector2(x_index, y_index), zones[y_index][x_index])
				x_index += 1
		y_index += 1
