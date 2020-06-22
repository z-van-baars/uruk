extends ColorRect
var player

func _ready():
	player = get_tree().root.get_node("Main/Player")
	update_labels()

func update_labels():
	$Grain.text = "Grain - " + str(player.grain)

func _on_Player_update_resource_bar():
	update_labels()
