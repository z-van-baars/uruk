extends Node2D
var width
var height
onready var terrain_map = get_tree().root.get_node("Main/WorldGen").terrain
onready var resource_map = get_tree().root.get_node("Main/WorldGen").resources
onready var building_map = get_tree().root.get_node("Main/WorldGen").building_map

func is_blocked(tile_coordinates):
	if in_map(tile_coordinates) == false: return true
	if terrain_map[tile_coordinates.y][tile_coordinates.x] == 2: return true
	if resource_map[tile_coordinates.y][tile_coordinates.x] != null: return true
	if building_map[tile_coordinates.y][tile_coordinates.x] != null: return true
	return false

func set_map_parameters():
	width = get_tree().root.get_node("Main/WorldGen").width
	height = get_tree().root.get_node("Main/WorldGen").height

func r_choice(some_array):
	return some_array[randi() % some_array.size()]

func shuffleList(list):
	var shuffledList = []
	var indexList = range(list.size())
	for i in range(list.size()):
		randomize()
		var x = randi()%indexList.size()
		shuffledList.append(list[x])
		indexList.remove(x)
		list.remove(x)
	return shuffledList

func check_distance_above(point_to_check, existing_points, d_threshold):
	# Returns True if any point is within a given range of the point to check
	# Else False
	for point in existing_points:
		if distance(point_to_check.x, point_to_check.y,
					point.x, point.y) < d_threshold:
			return true
	return false


func filter_tiles(tile_list: Array, water=false):
	# Returns a filtered list of tiles excluding either land or water tiles
	var water_tiles = []
	var land_tiles = []
	var biome_map = get_tree().root.get_node("Main/WorldGen/BiomeMap")
	var water_biomes = get_tree().root.get_node("Main/WorldGen/BiomeSelector").water_indexes
	var filtered_tiles = []
	for tile in tile_list:
		if biome_map.get_cellv(tile) in water_biomes:
			water_tiles.append(tile)
		else:
			land_tiles.append(tile)
	if water == true:
		return water_tiles
	else:
		return land_tiles

func get_neighbor_tiles(tile_address: Vector2):
	var x1 = tile_address.x
	var y1 = tile_address.y
	var all_neighbors = [
		Vector2(x1 - 1, y1 - 1),
		Vector2(x1,     y1 - 1),
		Vector2(x1 + 1, y1 - 1),
		Vector2(x1 - 1, y1),
		Vector2(x1 + 1, y1),
		Vector2(x1 - 1, y1 + 1),
		Vector2(x1,     y1 + 1),
		Vector2(x1 + 1, y1 + 1)]
	var in_map_neighbors = []
	for neighbor in all_neighbors:
		if (neighbor.x < width and
			neighbor.y < width and
			neighbor.x >= 0 and
			neighbor.y >= 0):
				in_map_neighbors.append(neighbor)
	return in_map_neighbors

func get_nearby_tiles(center_tile: Vector2, radius: float, inclusive=false):
	var nearby_tiles: Array = []
	# inclusive means leaving out the center tile if false, including if true
	for y in range(radius * 2 + 1):
		for x in range(radius * 2 + 1):
			if not in_map(Vector2(
				center_tile.x - radius + x,
				center_tile.y - radius + y)):
				continue
			if distance(
				center_tile.x,
				center_tile.y,
				center_tile.x - radius + x,
				center_tile.y - radius + y) <= radius:
				nearby_tiles.append(Vector2(center_tile.x - radius + x,
											center_tile.y - radius + y))
	return nearby_tiles

func in_map(tile):
	if tile.x < 0 or tile.y < 0:
		return false
	if tile.x >= width or tile.y >= height:
		return false
	return true

func cull_duplicates(array: Array):
	var new_dict = {}
	for entry in array:
		new_dict[entry] = null
	return new_dict.keys()

func min_arr(arr: Array):
	# Returns the smallest element of an array
	var min_val = arr[0]
	for i in range(1, arr.size()):
		min_val = min(min_val, arr[i])
	return min_val

func max_arr(arr: Array):
	# Returns the largest element of an array
	var max_val = arr[0]
	for i in range(1, arr.size()):
		max_val = max(max_val, arr[i])
	return max_val

func distance(a1: float, b1: float, x1: float, y1: float):
	# Pythagorean distance between two points, Vector2(a,b) and Vector2(x,y)
	# Returns an unrounded float
	var a2 = abs(a1 - x1)
	var b2 = abs(b1 - y1)
	return sqrt((a2 * a2) + (b2 * b2))

func get_tiles_in_zone(zone_start, zone_end):
	var leftmost = zone_start.x
	var topmost = zone_start.y
	var rightmost = zone_end.x
	var bottommost = zone_end.y
	if zone_start.x > zone_end.x:
		leftmost = zone_end.x
		rightmost = zone_start.x
	if zone_start.y > zone_end.y:
		topmost = zone_end.y
		bottommost = zone_start.y
	var all_tiles = []
	var x_index = leftmost
	var y_index = topmost

	for y in range(bottommost - topmost + 1):
		x_index = leftmost
		for x in range(rightmost - leftmost + 1):
			all_tiles.append(Vector2(x_index, y_index))
			x_index += 1
		y_index += 1
	
	return all_tiles
			


func sort_list(item_list, low=true):
	var sorted_list = []
	for each in item_list:
		for sorted_item in sorted_list:
			if each < sorted_item:
				sorted_list.insert(each, sorted_list.find(sorted_item))
	if low == true:
		return sorted_list
	return sorted_list.invert()

func element_sort(item_list, e_index=0):
	var sorted_list = [item_list[0]]
	for each in item_list.slice(1, item_list.size()-1):
		for sorted_item in sorted_list:
			if each[0] < sorted_item[0] and sorted_item[1] != each[1]:
				sorted_list.insert(sorted_list.find(sorted_item), [each[0], each[1]])
				continue
	return sorted_list

func get_position_from_tile(tile, neighbor_tile):
	# Return an int from 0-7 based on clockwise rotation from a given tile
	# Return Null if neighbor tile isn't a valid neighbor
	var tile_positions = {
		0: Vector2(-1, -1),
		1: Vector2(0, -1),
		2: Vector2(1, -1),
		3: Vector2(1, 0),
		4: Vector2(1, 1),
		5: Vector2(0, 1),
		6: Vector2(-1, 1),
		7: Vector2(-1, 0)}
	for position_id in tile_positions.keys():
		if neighbor_tile - tile == tile_positions[position_id]:
			return position_id
	return null

func get_tile_from_position(tile, position_id):
	var tile_positions = {
		0: Vector2(-1, -1),
		1: Vector2(0, -1),
		2: Vector2(1, -1),
		3: Vector2(1, 0),
		4: Vector2(1, 1),
		5: Vector2(0, 1),
		6: Vector2(-1, 1),
		7: Vector2(-1, 0)}
	return tile + position_id
