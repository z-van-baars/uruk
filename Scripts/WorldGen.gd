extends Node2D

var terrain = []
var resources = []
var buildings = []
var zones = []

func gen_new(dimensions):
	for y in range(dimensions.y):
		var terrain_row = []
		var resource_row = []
		var building_row = []
		var zone_row = []
		for x in range(dimensions.x):
			terrain_row.append(0)
			resource_row.append(null)
			building_row.append(null)
			zone_row.append(null)
		terrain.append(terrain_row)
		resources.append(resource_row)
		buildings.append(building_row)
		zones.append(zone_row)
	gen_resources(dimensions)

func gen_resources(dimensions):
	var width = int(dimensions.x)
	var height = int(dimensions.y)

	var n_trees = randi()%(width * width)
	var n_rocks = randi()%width * 3
	var n_copper = randi()%width

	for t in range(n_trees):
		var random_pos = Vector2(randi()%width, randi()%height)
		resources[random_pos.y][random_pos.x] = 2
	for r in range(n_rocks):
		var random_pos = Vector2(randi()%width, randi()%height)
		resources[random_pos.y][random_pos.x] = 1
	for c in range(n_copper):
		var random_pos = Vector2(randi()%width, randi()%height)
		resources[random_pos.y][random_pos.x] = 0


