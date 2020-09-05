extends Node2D
signal demand_updated
signal production_updated
signal increment_resources

onready var building_map = get_tree().root.get_node("Main/WorldGen").building_map
onready var building_tilemap = get_tree().root.get_node("Main/WorldGen/BuildingTileMap")
onready var tools = get_tree().root.get_node("Main/Tools")
onready var build_timer = get_tree().root.get_node("Main/BuildTimer")
onready var production_timer = get_tree().root.get_node("Main/ProductionTimer")

var cached_consumption
var cached_production
var cached_demand
var cached_satisfaction

var building_cost = {
	null: {},
	"temple": {"wood": 1},
	"market": {"wood": 2}}

var building_scene = preload("res://Scenes/Building.tscn")

func recalculate_all():
	cached_consumption = calculate_consumption()
	cached_production = calculate_production()
	cached_demand = calculate_demand()
	cached_satisfaction = calculate_satisfaction()

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
	var net_production = cached_production
	for resource in cached_consumption.keys():
		net_production[resource] -= cached_consumption[resource]
	emit_signal("production_updated", net_production)
	emit_signal("increment_resources", net_production)

func new_building(building_string, building_pos):
	var new_building = building_scene.instance()
	add_child(new_building)
	new_building.load_building(building_string, building_pos)
	building_tilemap.set_new_building(building_string, building_pos)

func is_built(input_tile):
	if building_map[input_tile.y][input_tile.x] == null:
		return false
	return true
			
func calculate_unmet_demand():
	var unmet_demand = {
		"farmland": 0,
		"slums": 0,
		"artisan": 0,
		"artisan housing": 0,
		"noble housing": 0}
	for zone_type in cached_demand.keys():
		unmet_demand[zone_type] = cached_demand[zone_type] - cached_satisfaction[zone_type]
	unmet_demand["farmland"] += 2
	unmet_demand["slums"] += 1
	return unmet_demand

func calculate_satisfaction():
	var satisfaction = {
		"farmland": 0,
		"slums": 0,
		"artisan": 0,
		"artisan housing": 0,
		"noble housing": 0,
		"other": 0}
	for building in get_children():
		satisfaction[building.get_zone_type()] += 1
	return satisfaction
		
func calculate_demand():
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


func get_cost(building_string):
	return building_cost[building_string]
