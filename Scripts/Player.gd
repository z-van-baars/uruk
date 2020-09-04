extends Node2D

signal update_dock
signal update_resource_bar
signal toggle_build_mode
signal update_maps
signal shake_catalyst

var mouse_in_menu = false

onready var worldgen = get_tree().root.get_node("Main/WorldGen")
onready var tools = get_tree().root.get_node("Main/Tools")
onready var zones = get_tree().root.get_node("Main/Zones")
onready var zone_preview_map = get_tree().root.get_node("Main/WorldGen/ZonePreviewMap")
onready var selection_box = get_tree().root.get_node("Main/WorldGen/SelectionBox")
onready var cost_box = get_tree().root.get_node("Main/CostBox")
onready var buildings = get_tree().root.get_node("Main/Buildings")
var building_to_construct = 0

var build_mode = false
var to_build = null

var zoning_mode = false
var to_zone = null
var zone_start = Vector2.ZERO
var zone_end = Vector2.ZERO
var zone_tiles = []
var dragging_zone = false


var stockpile = {
	"labor": 100,
	"grain": 0,
	"wood": 100,
	"stone": 0,
	"copper": 0,
	"tin": 0,
	"bronze": 0,
	"gold": 0}

func _on_mouse_entered_menu():
	mouse_in_menu = true

func _on_mouse_exited_menu():
	mouse_in_menu = false
	
func _process(delta):
	if dragging_zone == true and to_zone != null:
		var selected_tile = selection_box.get_selected_tile()
		if selected_tile.x == zone_end.x and selected_tile.y == zone_end.y: return
		zone_end = selected_tile
		zone_tiles = zones.get_unblocked(zone_start, zone_end)
		zone_preview_map.reset_preview_zone(zone_tiles, to_zone)
		cost_box.set_cost_label(zones.get_zone_cost(to_zone, zone_tiles))

func _input(event):
	
	if $Camera2D.scrolling == true:
		return
	if event.is_action_pressed("left_click"):
		print("build mode is: " + str(build_mode))
		print("zoning mode is: " + str(zoning_mode))
		if build_mode == false and zoning_mode == false: return
		if mouse_in_menu == true: return

		if build_mode == false and zoning_mode == true:
			var selected_tile = selection_box.get_selected_tile()
			zone_start = selected_tile
			zone_end = selected_tile
			zone_tiles = zones.get_unblocked(
				selected_tile, selected_tile)
			dragging_zone = true
			cost_box.set_cost_label(
				zones.get_zone_cost(to_zone, zone_tiles))
			emit_signal("update_maps")
		elif build_mode == true and zoning_mode == false:
			var selected_tile = selection_box.get_selected_tile()
			worldgen.building_map[selected_tile.y][selected_tile.x] = to_build
			emit_signal("shake_catalyst", 3.0)
			get_tree().root.get_node(
				"Main/WorldGen/BuildingTileMap").set_cellv(
					selected_tile,
					to_build)
			buildings.new_building(to_build, selected_tile)
			emit_signal("update_maps")
	elif event.is_action_released("left_click"):
		if build_mode == false and zoning_mode == false: return
		if mouse_in_menu == true: return
		if build_mode == false and zoning_mode == true:
			var selected_tile = selection_box.get_selected_tile()
			zone_end = selected_tile
			dragging_zone = false
			zone_build()
			emit_signal("update_maps")
			zone_preview_map.clear()
			cost_box.set_cost_label(
				zones.get_zone_cost(
					to_zone,
					[zone_end]))
			emit_signal("shake_catalyst")
			if to_zone == 6 or zone_tiles.size() == 0:
				get_tree().root.get_node(
					"Main/Sounds/SFX/Fuzz1").stop()
			get_tree().root.get_node(
				"Main/Sounds/SFX/Thud1").stop()
			zone_tiles = []
		

func check_cost(zone_cost):
	return true

func zone_build():
	var zone_cost = zones.get_zone_cost(to_zone, zone_tiles)
	if check_cost(zone_cost) == false: return
	zones.set_zone(zone_tiles, to_zone)
	


func _on_Buildings_increment_resources(net_production):
	for resource in net_production.keys():
		stockpile[resource] += net_production[resource]
