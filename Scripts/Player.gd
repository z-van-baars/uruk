extends Node2D

signal update_dock
signal update_resource_bar
signal toggle_build_mode
signal update_maps

var mouse_in_menu = false

var worldgen
var tools
var zones
var zone_preview_map

var building_to_construct = 0

var build_mode = false
var to_build = null

var zoning_mode = false
var to_zone = null
var zone_start = Vector2.ZERO
var zone_end = Vector2.ZERO
var dragging_zone = false

var labor = 100
var grain = 0
var wood = 100
var stone = 0
var copper = 0
var tin = 0
var bronze = 0
var gold = 0

func _ready():
	worldgen = get_tree().root.get_node("Main/WorldGen")
	tools = get_tree().root.get_node("Main/Tools")
	zones = get_tree().root.get_node("Main/Zones")
	zone_preview_map = get_tree().root.get_node("Main/WorldGen/ZonePreviewMap")

func _on_mouse_entered_menu():
	mouse_in_menu = true

func _on_mouse_exited_menu():
	mouse_in_menu = false
	
func _process(delta):
	if dragging_zone == true:
		var selected_tile = get_tree().root.get_node("Main/WorldGen/SelectionBox").get_selected_tile()
		if selected_tile.x == zone_end.x and selected_tile.y == zone_end.y: return
		print(selected_tile)
		print(zone_end)
		zone_end = selected_tile
		var zone_tiles = tools.get_tiles_in_zone(zone_start, zone_end)
		zone_preview_map.reset_preview_zone(zone_tiles, to_zone)

func _input(event):
	if $Camera2D.scrolling == true:
		return
	if event.is_action_pressed("ui_b"):
		build_mode = !build_mode
		emit_signal("update_dock")
		emit_signal("toggle_build_mode")
	elif event.is_action_pressed("left_click"):
		if build_mode == false and zoning_mode == false: return
		if mouse_in_menu == true: return

		if build_mode == false and zoning_mode == true:
			var selected_tile = get_tree().root.get_node("Main/WorldGen/SelectionBox").get_selected_tile()
			zone_start = selected_tile
			zone_end = selected_tile
			dragging_zone = true
			emit_signal("update_maps")
		elif build_mode == true and zoning_mode == false:
			var selected_tile = get_tree().root.get_node("Main/WorldGen/SelectionBox").get_selected_tile()
			worldgen.buildings[selected_tile.y][selected_tile.x] = to_build
			get_tree().root.get_node("Main/WorldGen/BuildingTileMap").set_cellv(selected_tile, to_build)
			emit_signal("update_maps")
	elif event.is_action_released("left_click"):
		if build_mode == false and zoning_mode == false: return
		if mouse_in_menu == true: return
		if build_mode == false and zoning_mode == true:
			var selected_tile = get_tree().root.get_node("Main/WorldGen/SelectionBox").get_selected_tile()
			zone_end = selected_tile
			dragging_zone = false
			zone_build()
			emit_signal("update_maps")
			zone_preview_map.clear()
		

func check_cost(zone_cost):
	return true

func zone_build():
	var zone_cost = zones.get_cost(to_zone, zone_start, zone_end)
	if check_cost(zone_cost) == false: return
	var zone_tiles = tools.get_tiles_in_zone(zone_start, zone_end)
	zones.set_zone(zone_tiles, to_zone)
	
