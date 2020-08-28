extends TileMap
var width
var height

var zone_tile_ids = {
	0: 3,
	1: 0,
	2: 5,
	3: 4,
	4: 2,
	6: 6}

func load_map():
	width = get_tree().root.get_node("Main/WorldGen").width
	height = get_tree().root.get_node("Main/WorldGen").height

func reset_preview_zone(zone_tiles, zone_type):
	clear()
	for tile in zone_tiles:
		set_cellv(tile, zone_tile_ids[zone_type])
