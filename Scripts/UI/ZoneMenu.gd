extends Control
signal mouse_entered_menu
signal mouse_exited_menu
var selection_box
var cost_box
var player
var zones

func _ready():
	selection_box = get_tree().root.get_node("Main/WorldGen/SelectionBox")
	cost_box = get_tree().root.get_node("Main/CostBox")
	player = get_tree().root.get_node("Main/Player")
	zones = get_tree().root.get_node("Main/Zones")



func _on_FarmlandButton_pressed():
	player.to_zone = 0
	

func _on_SlumsButton_pressed():
	player.to_zone = 1
	selection_box.set_zone(1)
	activate_cost_box()

func _on_ArtisanButton_pressed():
	player.to_zone = 2
	selection_box.set_zone(2)
	activate_cost_box()

func _on_ArtisanHousingButton_pressed():
	player.to_zone = 3
	selection_box.set_zone(3)
	activate_cost_box()

func _on_NobleHousingButton_pressed():
	enable_zoning_mode()
	player.to_zone = 4
	selection_box.set_zone(4)
	activate_cost_box()

func _on_DezoneButton_pressed():
	enable_zoning_mode()
	player.to_zone = 6
	selection_box.set_zone(6)
	activate_cost_box()

func _on_ZoneMenu_mouse_entered():
	emit_signal("mouse_entered_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: True"

func _on_ZoneMenu_mouse_exited():
	emit_signal("mouse_exited_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: False"

func _on_BulldozeButton_pressed():
	disable_zoning_mode()
	hide()
