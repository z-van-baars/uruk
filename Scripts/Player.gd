extends Node2D

signal update_dock
signal update_resource_bar

var worldgen

var building_to_construct = 0

var scroll_x = 0
var scroll_y = 0
var scroll_speed = 200

var build_mode = false

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
	if event.is_action_pressed("ui_w"):
		scroll_y -= scroll_speed
	elif event.is_action_pressed("ui_a"):
		scroll_x -= scroll_speed
	elif event.is_action_pressed("ui_d"):
		scroll_x += scroll_speed
	elif event.is_action_pressed("ui_s"):
		scroll_y += scroll_speed
	elif event.is_action_released("ui_w"):
		scroll_y += scroll_speed
	elif event.is_action_released("ui_s"):
		scroll_y -= scroll_speed
	elif event.is_action_released("ui_a"):
		scroll_x += scroll_speed
	elif event.is_action_released("ui_d"):
		scroll_x -= scroll_speed
	elif event.is_action_pressed("ui_b"):
		build_mode = !build_mode
		emit_signal("update_dock")
	elif event.is_action_pressed("left_click"):
		if build_mode == true:
			var selected_tile = get_tree().root.get_node("Main/SelectionBox").get_selected_tile()
			worldgen.buildings[selected_tile.y][selected_tile.x] = building_to_construct
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

func _process(delta):
	if scroll_x != 0:
		$Camera2D.position.x += scroll_x * delta
	if scroll_y != 0:
		$Camera2D.position.y += scroll_y * delta
