extends Sprite

var sprites_by_type = {
	"farm1": "res://Assets/buildings/farm.png",
	"huts1": "res://Assets/buildings/huts_4.png",}


func load_building_sprite(building_type):
	texture = load(sprites_by_type[building_type])
