extends Control
var player
var selection_box

func _ready():
	player = get_tree().root.get_node("Main/Player")
	selection_box = get_tree().root.get_node("Main/WorldGen/SelectionBox")

func _on_LumberCampButton_pressed():
	print("pressed LB")
	player.to_build = 2
	selection_box.activate_build_sprite()


func _on_MineButton_pressed():
	print("pressed MB")
	player.to_build = 3
	selection_box.activate_build_sprite()
