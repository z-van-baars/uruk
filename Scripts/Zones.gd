extends Node2D
var zone_tilemap

var farmland_cost = {
	"wood": 1,
	"labor": 1}
var slums_cost = {
	"labor": 1}
var artisan_cost = {
	"wood": 2,
	"stone": 1,
	"labor": 2}
var artisan_housing_cost = {
	"wood": 1,
	"stone": 2,
	"labor": 2}
var noble_housing_cost = {
	"wood": 5,
	"stone": 10,
	"labor": 5,
	"copper": 2}
var zone_costs = {
	"farmland": farmland_cost,
	"slums": slums_cost,
	"artisan": artisan_cost,
	"artisan housing": artisan_housing_cost,
	"noble housing": noble_housing_cost}


var zone_types = [
	"farmland",
	"slums",
	"artisan",
	"artisan housing",
	"noble housing"]

var zone_tiles = {
	"farmland": 3,
	"slums": 0,
	"artisan": 5,
	"artisan housing": 4,
	"noble housing": 2}

func _ready():
	zone_tilemap = get_tree().root.get_node("Main/WorldGen/ZoneTileMap")

func get_cost(zone_type, zone_start, zone_end):
	var zone_size = (zone_end - zone_start).abs()
	var zone_area = zone_size.x * zone_size.y
	var total_zone_cost = {}
	for resource_type in zone_costs[zone_types[zone_type]].keys():
		total_zone_cost[resource_type] = zone_costs[zone_types[zone_type]][resource_type] * zone_size
	return total_zone_cost


func set_zone(zone_tiles, zone_type):
	print("setting zone")
	print(zone_tiles)
	print(zone_type)
	for tile in zone_tiles:
		zone_tilemap.set_cellv(tile, zone_type)
