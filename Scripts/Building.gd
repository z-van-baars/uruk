extends Node2D

var building_type = null
var zone_type = null
var demand = {
	"farm1": {"slums": 0.25},
	"huts1": {"farmland": 2}}
var tick_production = {
	"farm1": {"grain": 11},
	"huts1": {"labor": 1}}
var tick_consumption = {
	"farm1": {"labor": 1},
	"huts1": {"grain": 10}}
var zone_types = {
	"farm1": "farmland",
	"huts1": "slums"}

var satisfactor = {
	"farm1": 1,
	"huts1": 1}

func load_building(building_name):
	building_type = building_name
	zone_type = zone_types[building_name]
	$Sprite.load_building_sprite(building_name)

func get_demand():
	return demand[building_type]

func get_consumption():
	return tick_consumption[building_type]

func get_production():
	return tick_production[building_type]

func get_zone_satisfaction():
	return satisfactor[building_type]

func get_zone_type():
	return zone_types[building_type]
