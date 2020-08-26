extends Node2D

signal update_dock
signal update_resource_bar
signal toggle_build_mode
signal update_maps

var worldgen

var building_to_construct = 0

var build_mode = false
var to_build = null

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


func _input(event):
	if $Camera2D.scrolling == true:
		return
	if event.is_action_pressed("ui_b"):
		build_mode = !build_mode
		emit_signal("update_dock")
		emit_signal("toggle_build_mode")
	elif event.is_action_pressed("left_click"):
		if build_mode == false:
			return
		var selected_tile = get_tree().root.get_node("Main/WorldGen/SelectionBox").get_selected_tile()
		worldgen.buildings[selected_tile.y][selected_tile.x] = to_build
		get_tree().root.get_node("Main/WorldGen/BuildingTileMap").set_cellv(selected_tile, to_build)
		emit_signal("update_maps")

	elif event.is_action_pressed("ui_up"):
		if build_mode == true:
			if building_to_construct == 0:
				building_to_construct = 2
			else:
				building_to_construct -= 1
			emit_signal("update_dock")
	elif event.is_action_pressed("ui_down"):
		if build_mode == true:
			if building_to_construct == 2:
				building_to_construct = 0
			else:
				building_to_construct += 1
			emit_signal("update_dock")

