extends Node2D
signal update_resources
signal shake_catalyst

onready var worldgen = get_tree().root.get_node("Main/WorldGen")
onready var tools = get_tree().root.get_node("Main/Tools")
onready var cursor = get_tree().root.get_node("Main/UILayer/Cursor")
onready var buildings = get_tree().root.get_node("Main/Buildings")

var mouse_in_menu = false
var build_mode = false
var to_build = null


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

func _input(event):
	if $Camera2D.scrolling == true:
		return
		
	# old left click code
	if event.is_action_pressed("left_click"):
		if mouse_in_menu == true or build_mode == false: return
		elif build_mode == true and to_build != null:
			var selected_tile = cursor.get_selected_tile()
			if tools.is_blocked(selected_tile):
				return
			var building_cost = buildings.get_cost(to_build)
			if check_cost(building_cost) == false:
				return
			worldgen.building_map[selected_tile.y][selected_tile.x] = to_build
			buildings.new_building(to_build, selected_tile)
			subtract_cost(building_cost)
			emit_signal("shake_catalyst", 3.0)
			emit_signal("update_resources")
	# end old code

	if event.is_action_pressed("left_click"):
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

	elif event.is_action_pressed("land_value_view"):
		get_tree().root.get_node("Main/UILayer/Cursor/LandValueLabel").visible = !get_tree().root.get_node("Main/UILayer/Cursor/LandValueLabel").visible
		get_tree().root.get_node("Main/WorldGen/LandValueTileMap").paint_land_value()
		get_tree().root.get_node("Main/WorldGen/LandValueTileMap").visible = !get_tree().root.get_node("Main/WorldGen/LandValueTileMap").visible


func check_cost(total_cost):
	for resource in total_cost.keys():
		if stockpile[resource] < total_cost[resource]: return false
	return true

func subtract_cost(total_cost):
	for resource in total_cost.keys():
		stockpile[resource] -= total_cost[resource]

func _on_Buildings_increment_resources(net_production):
	for resource in net_production.keys():
		stockpile[resource] += net_production[resource]
