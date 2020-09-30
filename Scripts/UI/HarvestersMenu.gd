extends Control
onready var player = get_tree().root.get_node("Main/Player")
onready var build_cursor = get_tree().root.get_node("Main/BuildCursor")
signal mouse_entered_menu
signal mouse_exited_menu


func _on_LumberCampButton_pressed():
	print("pressed LB")
	player.to_build = "lumber camp"
	build_cursor.activate_build_sprite()


func _on_MineButton_pressed():
	print("pressed MB")
	player.to_build = "mine"
	build_cursor.activate_build_sprite()


func _on_HarvestersMenu_mouse_entered():
	emit_signal("mouse_entered_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: True"


func _on_HarvestersMenu_mouse_exited():
	emit_signal("mouse_exited_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: False"


func _on_ZonesMenu_mouse_entered():
	emit_signal("mouse_entered_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: True"


func _on_ZonesMenu_mouse_exited():
	emit_signal("mouse_exited_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: False"
