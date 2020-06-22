extends Node


func _ready():
	$WorldGen.gen_new(Vector2(10, 10))
	$WorldGen/TerrainTileMap.paint_terrain_map($WorldGen.terrain)
