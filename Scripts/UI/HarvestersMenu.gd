extends Control
var player
var selection_box

func _ready():
	player = get_tree().root.get_node("Main/Player")

func _on_LumberCampButton_pressed():
	player.to_build = 2
	selection_box.activate_build_sprite()


func _on_MineButton_pressed():
	player.to_build = 3
	selection_box.activate_build_sprite()
