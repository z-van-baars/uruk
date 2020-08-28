extends Node2D



var demand_for = {
	"farmland": 0,
	"slums": 0,
	"artisan": 0,
	"artisan housing": 0,
	"noble housing": 0}

var buildings

func _ready():
	buildings = get_tree().root.get_node("Main/Buildings")



func calculate_demand():
	for building in buildings.get_children():
		building.get_demand()
