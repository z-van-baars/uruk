extends TileMap

onready var land_value_map = get_tree().root.get_node("Main/WorldGen").land_value_map

func _process(delta):
	paint_land_value()

func paint_land_value():
	clear()
	var x_index = 0
	var y_index = 0
	for row in land_value_map:
		for value in row:
			if value > 50:
				set_cellv(Vector2(x_index, y_index), 1)
			elif value < 50:
				set_cellv(Vector2(x_index, y_index), 0)
			x_index += 1
		x_index = 0
		y_index += 1
