extends Node


func _ready():
	$WorldGen.gen_new(Vector2(200, 200))
	
	$WorldGen/TerrainTileMap.load_map()
	$WorldGen/TerrainTileMap.paint_terrain()
	$WorldGen/ZoneTileMap.load_map()
	$WorldGen/ZoneTileMap.paint_zones()
	$WorldGen/ZonePreviewMap.clear()
	$WorldGen/ResourceTileMap.load_map()
	$WorldGen/ResourceTileMap.paint_resources()
	$WorldGen/BuildingTileMap.load_map()
	$WorldGen/BuildingTileMap.paint_buildings()
	$Player/Camera2D.center_on_tile(Vector2(50, 50))
	$Player.connect(
		"toggle_build_mode",
		$WorldGen/SelectionBox,
		"_on_toggle_build_mode")
	$BuildTimer.start()
