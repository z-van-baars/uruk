extends Node2D
var tile_map
var zones
var player

var build_sprites = {}
var zone_sprites = {}

var pos = Vector2(0, 0)
var selected_tile
var build_mode = false
var zoning_mode = false

func _ready():
	tile_map = get_tree().root.get_node("Main/WorldGen/TerrainTileMap")
	zones = get_tree().root.get_node("Main/Zones")
	player = get_tree().root.get_node("Main/Player")
	var build_sprites = {
		
	}
	zone_sprites = {
		0: $ZoneSprites/Farmland,
		1: $ZoneSprites/Slums,
		2: $ZoneSprites/Artisan,
		3: $ZoneSprites/ArtisanHousing,
		4: $ZoneSprites/NobleHousing,
		-1: $ZoneSprites/Bulldoze,
		-2: $ZoneSprites/Blank,
		6: $ZoneSprites/Dezone}
	build_sprites = {
		0: $buildingSprites/Farm1,
		1: $BuildingSprites/House1,
		2: $BuildingSprites/LumberCamp,
		3: $BuildingSprites/Mine,
		4: $BuildingSprites/Smelter,
		5: $BuildingSprites/Temple}

func _process(delta):
	if build_mode == false and zoning_mode == false:
		return
	pos = get_viewport().get_mouse_position()
	pos = get_viewport().get_canvas_transform().xform_inv(pos)
	selected_tile = tile_map.world_to_map(pos)
	position = tile_map.map_to_world(selected_tile)

func get_selected_tile():
	return selected_tile

func _on_toggle_build_mode():
	build_mode = !build_mode
	visible = !visible

func _on_toggle_zoning_mode():
	zoning_mode = !zoning_mode
	all_off()
	visible = !visible

func all_off():
	for each in $ZoneSprites.get_children():
		each.hide()
	for each in $BuildingSprites.get_children():
		each.hide()

func activate_build_sprite():
	all_off()
	if player.to_build == null: return
	build_sprites[player.to_build].show()
	
func set_zone(zone_type):
	all_off()
	zone_sprites[player.to_zone].show()
