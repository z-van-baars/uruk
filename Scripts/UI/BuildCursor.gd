extends Node2D

onready var tools = get_tree().root.get_node("Main/Tools")
onready var tile_map = get_tree().root.get_node("Main/WorldGen/TerrainTileMap")
onready var player = get_tree().root.get_node("Main/Player")

var build_sprites
var selected_tile = Vector2.ZERO

func _ready():
	build_sprites = {
		"lumber camp": $BuildingSprites/LumberCamp,
		"mine": $BuildingSprites/Temple,
		"smelter": $BuildingSprites/Temple,
		"temple": $BuildingSprites/Temple,
		"market": $BuildingSprites/Market}

func _process(delta):
	if player.build_mode == false:
		hide()
		return
	show()
	activate_build_sprite()
	position = tile_map.map_to_world(selected_tile)
	modulate = Color.white
	if tools.is_blocked(selected_tile) == true:
		modulate = Color.red
	else:
		modulate = Color.limegreen


func activate_build_sprite():
	for b_sprite in build_sprites.keys():
		build_sprites[b_sprite].hide()
	if player.to_build == null: return
	build_sprites[player.to_build].show()
