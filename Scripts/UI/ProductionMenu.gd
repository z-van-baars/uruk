extends Control
var player
var selection_box
signal mouse_entered_menu
signal mouse_exited_menu

func _ready():
	player = get_tree().root.get_node("Main/Player")
	selection_box = get_tree().root.get_node("Main/WorldGen/SelectionBox")



func _on_SmelterButton_pressed():
	player.to_build = "smelter"
	selection_box.activate_build_sprite()


func _on_ProcessorsMenu_mouse_entered():
	emit_signal("mouse_entered_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: True"


func _on_ProcessorsMenu_mouse_exited():
	emit_signal("mouse_exited_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: False"
