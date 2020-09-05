extends Node2D

var terrain = []
var resources = []
var building_map = []
var land_value_map = []
var security_map = []
var width : int
var height : int
var noise = OpenSimplexNoise.new()

func gen_new_blank(dimensions):
	width = int(dimensions.x)
	height = int(dimensions.y)
	for y in range(dimensions.y):
		var terrain_row = []
		var resource_row = []
		var building_row = []
		var land_value_row = []
		var security_row = []
		for x in range(dimensions.x):
			terrain_row.append(0)
			resource_row.append(null)
			building_row.append(null)
			land_value_row.append(50)
			security_row.append(50)
		terrain.append(terrain_row)
		resources.append(resource_row)
		building_map.append(building_row)
		land_value_map.append(land_value_row)
		security_map.append(security_row)

func randomize_terrain():
	var treemap = generate_treemap()
	var sparse_forest_threshold = 0.61
	var forest_threshold = 0.62
	var thick_forest_threshold = 0.65

	var x_index = 0
	var y_index = 0
	for row in treemap:
		for tile in row:
			if tile >= sparse_forest_threshold and tile < forest_threshold:
				resources[y_index][x_index] = "sparse forest"
			elif tile >= forest_threshold and tile < thick_forest_threshold:
				resources[y_index][x_index] = "forest"
			elif tile >= thick_forest_threshold:
				resources[y_index][x_index] = "thick forest"
			x_index += 1
		y_index += 1
		x_index = 0
	var n_rocks = randi()%width * 3
	var n_copper = randi()%width

	for r in range(n_rocks):
		var random_pos = Vector2(randi()%width, randi()%height)
		if resources[random_pos.y][random_pos.x] != null:
			resources[random_pos.y][random_pos.x] = "stone"
	for r in range(n_copper):
		var random_pos = Vector2(randi()%width, randi()%height)
		if resources[random_pos.y][random_pos.x] != null:
			resources[random_pos.y][random_pos.x] = "copper"
	
	generate_random_river()


func generate_random_river():
	var sides = {0: "northwest", 1: "northeast"}
	randomize()
	var starting_side = randi() % 2
	var river_width = 6
	var river_frontier = []
	var river_vec = Vector2()
	if starting_side == 0:
		river_vec = Vector2(1, 0)
		for n in range(river_width):
			river_frontier.append(
				Vector2(
					0,
					int(width / 2 - river_width / 2 + n)))
	elif starting_side == 1:
		river_vec = Vector2(0, 1)
		for n in range(river_width):
			river_frontier.append(Vector2(
				int(height / 2 - river_width / 2 + n),
				0))
	while river_frontier[0].x < width and river_frontier[0].y < height:
		var new_frontier = []
		for tile in river_frontier:
			terrain[tile.y][tile.x] = 2
			resources[tile.y][tile.x] = null
			new_frontier.append(tile + river_vec)
		river_frontier = new_frontier

func get_noise(nx, ny):
	# rescale from -1.0:+1/0 to 0.0:1.0
	# aka normalize
	return noise.get_noise_2d(nx, ny) / 2.0 + 0.5

func generate_treemap():
	var treemap = []
	for y in range(height):
		var row = []
		for x in range(width):
			var nx = (float(x) / float(width)) - 0.5
			var ny = (float(y) / float(height)) - 0.5

			# crunchify the noise by adding higher frequency noise
			# reduces banding and round edges / softness
			var rand_height_1 = 1.00 * get_noise(512 * nx, 512 * ny)
			rand_height_1 += 0.35 * get_noise(16 * nx, 16 * ny)
			rand_height_1 += 0.25 * get_noise(16 * nx, 16 * ny)
			# normalize the value, previous function produces large values
			var rand_height_final = rand_height_1 / (1.0 + 0.35 + 0.25)

			row.append(rand_height_final)
		treemap.append(row)
	return treemap



