extends Control
signal mouse_entered_menu
signal mouse_exited_menu
var zone_menu


func _ready():
	zone_menu = get_tree().root.get_node("Main/UILayer/ZoneMenu")


func _on_ZonesButton_pressed():
	get_tree().root.get_node("Main/WorldGen/SelectionBox")._on_toggle_zoning_mode()
	if zone_menu.visible == false:
		zone_menu.show()
	else:
		zone_menu.hide()
		zone_menu.disable_zoning_mode()


func _on_BuildWidget_mouse_entered():
	emit_signal("mouse_entered_menu")


func _on_BuildWidget_mouse_exited():
	emit_signal("mouse_exited_menu")
