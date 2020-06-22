extends ColorRect
var player
var building_names


func _ready():
	player = get_tree().root.get_node("Main/Player")
	building_names = get_tree().root.get_node("Main/Buildings").building_names
	update_labels()

func update_labels():
	$BuildMode.visible = player.build_mode
	$BuildMode.text = "Build Mode ------ " + building_names[player.building_to_construct]

func _on_Player_update_dock():
	update_labels()
