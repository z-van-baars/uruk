extends TileMap


func paint_resources():
	clear()
	var terrain_map = get_tree().root.get_node("Main/WorldGen").resources
	var y = 0
	var x = 0
	for row in terrain_map:
		for tile in row:
			if tile == null: 
				x += 1
				continue
			else:
				set_cellv(Vector2(x, y), tile)
				x += 1
		x = 0
		y += 1
