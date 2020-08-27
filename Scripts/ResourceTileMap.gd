extends TileMap
var resources = []

func load_map():
	resources = get_tree().root.get_node("Main/WorldGen").resources
	

func paint_resources():
	clear()
	var y = 0
	var x = 0
	for row in resources:
		for resource in row:
			if resource == null: 
				x += 1
				continue
			else:
				set_cellv(Vector2(x, y), resource)
				x += 1
		x = 0
		y += 1
