extends TileMap

var zoned_tiles
var undeveloped_zone_map

func load_map():
	zoned_tiles = get_tree().root.get_node("Main/WorldGen").zoned_tiles
	undeveloped_zone_map = get_tree().root.get_node("Main/WorldGen/UndevelopedZoneTileMap")
	
func paint_zones():
	clear()
	var y_index = 0
	for row in zoned_tiles:
		var x_index = 0
		for zone in row:
			if zone == null:
				x_index += 1
				continue
			else:
				set_cellv(Vector2(x_index, y_index), zoned_tiles[y_index][x_index])
				undeveloped_zone_map.set_cellv(Vector2(x_index, y_index), zoned_tiles[y_index][x_index])
				x_index += 1
		y_index += 1
