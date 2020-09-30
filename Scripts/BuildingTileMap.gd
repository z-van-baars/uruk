extends TileMap

var building_map
onready var tools = get_tree().root.get_node("Main/Tools")

var building_tiles = {
	"farm": [0],
	"huts1": [1],
	"lumber camp": [1],
	"mine": [1],
	"smelter": [1],
	"temple": [3],
	"market": [2]
}

func load_map():
	building_map = get_tree().root.get_node("Main/WorldGen").building_map

func paint_buildings():
	clear()
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


func set_new_building(building_str, building_pos):
	var building_tile_id = tools.r_choice(building_tiles[building_str])
	set_cellv(building_pos, building_tile_id)
