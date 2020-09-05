extends Node2D
var tools
var zone_tilemap
var buildings
var resource_map
var undeveloped_zone_tilemap

var farmland_cost = {
	"wood": 1,
	"labor": 1}
var slums_cost = {
	"stone": 1,
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
var dezone_cost = {}
var zone_costs = {
	"farmland": farmland_cost,
	"slums": slums_cost,
	"artisan": artisan_cost,
	"artisan housing": artisan_housing_cost,
	"noble housing": noble_housing_cost,
	"dezone": dezone_cost}


var zone_types = [
	"farmland",
	"slums",
	"artisan",
	"artisan housing",
	"noble housing",
	null,
	"dezone"]

var zone_tiles = {
	"farmland": 3,
	"slums": 0,
	"artisan": 5,
	"artisan housing": 4,
	"noble housing": 2}

var zone_tile_ids = {
	0: 3,
	1: 0,
	2: 5,
	3: 4,
	4: 2,
	6: -1}

var tiles_by_zone = {
	"farmland": [],
	"slums": [],
	"artisan": [],
	"artisan housing": [],
	"noble housing": []}


func _ready():
	tools = get_tree().root.get_node("Main/Tools")
	zone_tilemap = get_tree().root.get_node("Main/WorldGen/ZoneTileMap")
	undeveloped_zone_tilemap = get_tree().root.get_node("Main/WorldGen/UndevelopedZoneTileMap")
	buildings = get_tree().root.get_node("Main/Buildings")
	resource_map  = get_tree().root.get_node("Main/WorldGen").resources

func get_unbuilt(zone_str):
	var all_zoned = tiles_by_zone[zone_str]
	var unbuilt = []
	for zoned_tile in all_zoned:
		if buildings.is_built(zoned_tile) == false:
			unbuilt.append(zoned_tile)

	return unbuilt


func get_unblocked(zone_start, zone_end):
	var unblocked = []
	var zone_tiles = tools.get_tiles_in_zone(zone_start, zone_end)
	for zoned_tile in zone_tiles:
		if (resource_map[zoned_tile.y][zoned_tile.x] == null and
			buildings.is_built(zoned_tile) == false):
			unblocked.append(zoned_tile)
	return unblocked
