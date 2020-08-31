extends Node2D
signal demand_updated
signal production_updated
signal increment_resources

var building_map
var zone_tilemap
var zones
var tools
var build_timer
var production_timer

var building_scene = preload("res://Scenes/Building.tscn")

var tier_1 = {
	"farmland": "farm1",
	"slums": "huts1"}
var tier_2 = {"slums": "huts2"}

func _ready():
	building_map = get_tree().root.get_node("Main/WorldGen").building_map
	zone_tilemap = get_tree().root.get_node("Main/WorldGen/ZoneTileMap")
	zones = get_tree().root.get_node("Main/Zones")
	tools = get_tree().root.get_node("Main/Tools")
	build_timer = get_tree().root.get_node("Main/BuildTimer")
	production_timer = get_tree().root.get_node("Main/ProductionTimer")


func build_tick():
	var unmet_demand = calculate_unmet_demand()
	var remainder_demand = {
		"farmland": 0,
		"slums": 0,
		"artisan": 0,
		"artisan housing": 0,
		"noble housing": 0}
	emit_signal("demand_updated", unmet_demand)

	for zone_type in unmet_demand:
		if unmet_demand[zone_type] < 1:
			continue

		for _d in range(floor(unmet_demand[zone_type])):
			var zone_tiles = zones.get_unbuilt(zone_type)
			if zone_tiles.size() < 1: continue

			var random_zone_tile = tools.r_choice(zone_tiles)
			if random_zone_tile == null:
				remainder_demand[zone_type] += 1
				continue

			var new_building = building_scene.instance()
			add_child(new_building)
			new_building.load_building(tier_1[zone_type])
			building_map[random_zone_tile.y][random_zone_tile.x] = tier_1[zone_type]
			new_building.position = zone_tilemap.map_to_world(random_zone_tile)
			zones.undeveloped_zone_tilemap.set_cellv(random_zone_tile, -1)

func calculate_production():
	var raw_production = {
		"grain": 0,
		"wood": 0,
		"stone": 0,
		"labor": 0,
		"copper": 0,
		"tin": 0,
		"bronze": 0}
	for building in get_children():
		for resource in building.get_production().keys():
			raw_production[resource] += building.get_production()[resource]
	return raw_production

func calculate_consumption():
	var raw_consumption = {
		"grain": 0,
		"wood": 0,
		"stone": 0,
		"labor": 0,
		"copper": 0,
		"tin": 0,
		"bronze": 0}
	for building in get_children():
		for resource in building.get_consumption().keys():
			raw_consumption[resource] += building.get_consumption()[resource]
	return raw_consumption

func production_tick():
	var total_production = calculate_production()
	var total_consumption = calculate_consumption()
	var net_production = total_production
	for resource in total_consumption.keys():
		net_production[resource] -= total_consumption[resource]
	emit_signal("production_updated", net_production)
	emit_signal("increment_resources", net_production)

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
		satisfaction[building.get_zone_type()] += 1
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
				


func _on_ProductionTimer_timeout():
	build_timer.start()
	production_tick()


func _on_BuildTimer_timeout():
	production_timer.start()
	build_tick()
