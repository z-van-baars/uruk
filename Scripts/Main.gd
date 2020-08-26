extends Node


func _ready():
	$WorldGen.gen_new(Vector2(100, 100))
	$WorldGen/ResourceTileMap.paint_resources()
	$WorldGen/TerrainTileMap.paint_terrain_map($WorldGen.terrain)
	$Buildings.building_map = $WorldGen.buildings
	$Player/Camera2D.center_on_tile(Vector2(50, 50))
	$Player.connect(
		"toggle_build_mode",
		$WorldGen/SelectionBox,
		"_on_toggle_build_mode")
