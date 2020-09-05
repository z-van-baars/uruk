extends TileMap
onready var tools = get_tree().root.get_node("Main/Tools")
var resources = []
var resource_to_tile_id = {
	"sparse forest": [0],
	"forest": [1, 2, 3], 
	"thick forest": [4, 5],
	"stone": [6, 7, 8],
	"copper": [9],
	null: [-1]}


func load_map():
	resources = get_tree().root.get_node("Main/WorldGen").resources
	

func paint_resources():
	clear()
	var y = 0
	var x = 0
	for row in resources:
		for resource_str in row:
			if resource_str == null: 
				x += 1
				continue
			else:
				set_cellv(
					Vector2(x, y),
					tools.r_choice(resource_to_tile_id[resource_str]))
				x += 1
		x = 0
		y += 1
