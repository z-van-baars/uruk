extends Node


func _ready():
	# Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$WorldGen.gen_new_blank(Vector2(100, 100))
	$WorldGen.randomize_terrain()
	$Tools.set_map_parameters()
	$WorldGen/TerrainTileMap.load_map()
	$WorldGen/TerrainTileMap.paint_terrain()
	$WorldGen/ResourceTileMap.load_map()
	$WorldGen/ResourceTileMap.paint_resources()
	$WorldGen/BuildingTileMap.load_map()
	$WorldGen/BuildingTileMap.paint_buildings()
	$WorldGen/LandValueTileMap.paint_land_value()
	$Player/Camera2D.center_on_tile(Vector2(50, 50))
	$Player.connect(
		"toggle_build_mode",
		$WorldGen/SelectionBox,
		"_on_toggle_build_mode")
	$BuildTimer.start()
	$Buildings.recalculate_all()
