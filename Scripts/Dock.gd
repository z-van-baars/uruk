extends ColorRect
signal mouse_entered_menu
signal mouse_exited_menu
var player
var building_names


func _ready():
	player = get_tree().root.get_node("Main/Player")
	update_labels()

func update_labels():
	$BuildMode.visible = player.build_mode
	$BuildMode.text = "Build Mode"

func _on_Player_update_dock():
	update_labels()




func _on_Dock_mouse_entered():
	emit_signal("mouse_entered_menu")


func _on_Dock_mouse_exited():
	emit_signal("mouse_exited_menu")
