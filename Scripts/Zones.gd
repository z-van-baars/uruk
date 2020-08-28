extends Node2D
var zone_tilemap
var buildings
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

var zoned_tiles

func _ready():
	zone_tilemap = get_tree().root.get_node("Main/WorldGen/ZoneTileMap")
	undeveloped_zone_tilemap = get_tree().root.get_node("Main/WorldGen/UndevelopedZoneTileMap")
	buildings = get_tree().root.get_node("Main/Buildings")
	zoned_tiles = get_tree().root.get_node("Main/WorldGen").zoned_tiles



func get_cost(zone_type, zone_start, zone_end):
	var zone_size = (zone_end - zone_start).abs() + Vector2(1, 1)
	var zone_size_square = zone_size.x * zone_size.y
	var zone_area = zone_size.x * zone_size.y
	var total_zone_cost = {}
	for resource_type in zone_costs[zone_types[zone_type]].keys():
		total_zone_cost[resource_type] = zone_costs[zone_types[zone_type]][resource_type] * zone_size_square
	return total_zone_cost


func set_zone(zone_tiles, zone_id):
	var zone_str = zone_types[zone_id]
	for tile in zone_tiles:
		if zoned_tiles[tile.y][tile.x] != null:
			tiles_by_zone[zone_types[zoned_tiles[tile.y][tile.x]]].erase(tile)
		zone_tilemap.set_cellv(tile, zone_tile_ids[zone_id])
		undeveloped_zone_tilemap.set_cellv(tile, zone_tile_ids[zone_id])
		if zone_str == "dezone": continue
		tiles_by_zone[zone_str].append(tile)
		zoned_tiles[tile.y][tile.x] = zone_id

func get_available(zone_str):
	var all_zoned = tiles_by_zone[zone_str]
	var unbuilt = []
	for zoned_tile in all_zoned:
		if buildings.is_built(zoned_tile) == false:
			unbuilt.append(zoned_tile)
	return unbuilt
