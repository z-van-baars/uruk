extends ColorRect
signal mouse_entered_menu
signal mouse_exited_menu
var player
var building_names


func _ready():
	player = get_tree().root.get_node("Main/Player")


func _on_Dock_mouse_entered():
	emit_signal("mouse_entered_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: True"


func _on_Dock_mouse_exited():
	emit_signal("mouse_exited_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: False"
