extends Node2D

var terrain = []
var trees = []
var rocks = []
var buildings = []

func gen_new(dimensions):
	print(dimensions.y)
	print(dimensions.x)
	for y in range(dimensions.y):
		var row = []
		var tree_row = []
		var rock_row = []
		var building_row = []
		for x in range(dimensions.x):
			row.append(0)
			building_row.append(0)
			if randi()%10+1 > 6:
				tree_row.append(1)
			else:
				if randi()%10+1 > 9:
					rock_row.append(1)
				else:
					rock_row.append(0)
				tree_row.append(0)
		terrain.append(row)
		trees.append(tree_row)
		rocks.append(rock_row)
		buildings.append(building_row)


