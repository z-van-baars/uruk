extends Node2D

var building_map
var zone_tilemap
var zones
var tools

var building_scene = preload("res://Scenes/Building.tscn")

var tier_1 = {
	"farmland": "farm1",
	"slums": "huts1"}
func _ready():
	building_map = get_tree().root.get_node("Main/WorldGen").building_map
	zone_tilemap = get_tree().root.get_node("Main/WorldGen/ZoneTileMap")
	zones = get_tree().root.get_node("Main/Zones")
	tools = get_tree().root.get_node("Main/Tools")

func _process(delta):
	build_tick()

func build_tick():
	var unmet_demand = calculate_unmet_demand()
	for zone_type in unmet_demand:
		if unmet_demand[zone_type] < 1:
			continue
		for d in range(floor(unmet_demand[zone_type])):
			var zone_tiles = zones.get_available(zone_type)
			if zone_tiles.size() < 1:
				continue
			var random_zone_tile = tools.r_choice(zone_tiles)
			if random_zone_tile == null:
				continue
			var new_building = building_scene.instance()
			add_child(new_building)
			new_building.load_building(tier_1[zone_type])
			building_map[random_zone_tile.y][random_zone_tile.x] = tier_1[zone_type]
			new_building.position = zone_tilemap.map_to_world(random_zone_tile)
			zones.undeveloped_zone_tilemap.set_cellv(random_zone_tile, -1)

func is_built(input_tile):
	if building_map[input_tile.y][input_tile.x] == null:
		return false
	return true
			
func calculate_unmet_demand():
	var raw_demand = get_demand()
	var met_demand = get_satisfaction()
	var unmet_demand = {
		"farmland": 0,
		"slums": 0,
		"artisan": 0,
		"artisan housing": 0,
		"noble housing": 0}
	for zone_type in raw_demand.keys():
		unmet_demand[zone_type] = raw_demand[zone_type] - met_demand[zone_type]
	unmet_demand["farmland"] += 2
	unmet_demand["slums"] += 1
	return unmet_demand

func get_satisfaction():
	var satisfaction = {
		"farmland": 0,
		"slums": 0,
		"artisan": 0,
		"artisan housing": 0,
		"noble housing": 0}
	for building in get_children():
		satisfaction[building.get_zone_type()] += building.get_zone_satisfaction()
	return satisfaction
		
func get_demand():
	var raw_demand = {
		"farmland": 0,
		"slums": 0,
		"artisan": 0,
		"artisan housing": 0,
		"noble housing": 0}
	for building in get_children():
		for zone_type in building.get_demand().keys():
			raw_demand[zone_type] += building.get_demand()[zone_type]
	return raw_demand
				
