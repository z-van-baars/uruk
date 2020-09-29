extends Node2D
onready var tools = get_tree().root.get_node("Main/Tools")

var building_type = null
var coordinates = Vector2()
var aura_effect = null
var aura_tiles = []

onready var aura_fields = {
	"land value": get_tree().root.get_node("Main/WorldGen").land_value_map,
	"security": get_tree().root.get_node("Main/WorldGen").security_map
}

var demand = {
	"farm1": {"slums": 0.75},
	"huts1": {"farmland": 2},
	"lumber camp": {"slums": 0.10},
	"mine": {"slums": 0.10},
	"smelter": {"slums": 0.10},
	"temple": {"slums": 0.50},
	"market": {"slums": 10}}
var tick_production = {
	"farm1": {"grain": 1.1},
	"huts1": {"labor": 1},
	"mine": {},
	"smelter": {},
	"lumber camp": {}}
	
"""Field to affect, radius, value, flat effect or distanced"""
var aura_type = {
	"farm1": ["land value", 3, -1, false],
	"house1": null,
	"barracks": ["security", 3, 1, false],
	"temple": ["land value", 3, 2, true],
	"market": ["land value", 5, 1, true]}

var tick_consumption = {
	"farm1": {"labor": 1},
	"huts1": {"grain": 1},
	"temple": {
		"grain": 1,
		"labor": 1},
	"mine": {"labor": 1},
	"lumber camp": {"labor": 1},
	"smelter": {
		"labor": 1}}

func load_building(building_name, building_position):
	coordinates = building_position
	building_type = building_name
	aura_effect = aura_type[building_name]
	if aura_effect != null:
		aura_tiles = tools.get_nearby_tiles(coordinates, aura_effect[1], true)
		enact_aura()
	$Sprite.load_building_sprite(building_name)

func get_demand():
	return demand[building_type]

func get_consumption():
	return tick_consumption[building_type]

func get_production():
	return tick_production[building_type]

func enact_aura():
	if aura_effect == null: return
	var aura_map = aura_fields[aura_effect[0]]
	for tile in aura_tiles:
		var tile_value = aura_effect[2]
		if aura_effect[3] == true:
			var d = tools.distance(tile.x, tile.y, coordinates.x, coordinates.y)
			tile_value *= (aura_effect[1] - d / aura_effect[1] + 1)
		aura_map[tile.y][tile.x] += tile_value
	

