extends Sprite

var sprites_by_type = {
	"farm1": "res://Assets/buildings/farm.png",
	"huts1": "res://Assets/buildings/huts_4.png",
	"lumber camp": "res://Assets/buildings/lumbercamp.png",
	"mine": "res://Assets/buildings/mine.png",
	"temple": "res://Assets/buildings/temple.png",
	"smelter": "res://Assets/buildings/smelter.png"}


func load_building_sprite(building_type):
	texture = load(sprites_by_type[building_type])
