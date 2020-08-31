extends Control
var player
var selection_box

func _ready():
	player = get_tree().root.get_node("Main/Player")
	selection_box = get_tree().root.get_node("Main/WorldGen/SelectionBox")



func _on_SmelterButton_pressed():
	player.to_build = 4
	selection_box.activate_build_sprite()
