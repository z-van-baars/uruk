extends Control
onready var player = get_tree().root.get_node("Main/Player")
onready var build_cursor = get_tree().root.get_node("Main/BuildCursor")
signal mouse_entered_menu
signal mouse_exited_menu

	
func _on_TempleButton_pressed():
	player.to_build = "temple"
	build_cursor.activate_build_sprite()

func _on_MarketButton_pressed():
	player.to_build = "market"
	build_cursor.activate_build_sprite()


func _on_BoostersMenu_mouse_entered():
	emit_signal("mouse_entered_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: True"


func _on_BoostersMenu_mouse_exited():
	emit_signal("mouse_exited_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: False"

