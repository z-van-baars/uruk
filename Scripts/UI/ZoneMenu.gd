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

func enable_zoning_mode():
	selection_box.zoning_mode = true
	selection_box.show()

	player.zoning_mode = true
	player.emit_signal("update_dock")

func disable_zoning_mode():
	selection_box.zoning_mode = false
	selection_box.hide()
	player.zoning_mode = false
	player.to_zone = null
	player.emit_signal("update_dock")

func activate_cost_box():
	cost_box.set_cost_label(
		zones.get_zone_cost(
			player.to_zone,
			zones.get_zone_cost(player.to_zone, [Vector2.ZERO])))

func _on_FarmlandButton_pressed():
	enable_zoning_mode()
	player.to_zone = 0
	selection_box.set_zone(0)
	activate_cost_box()
	

func _on_SlumsButton_pressed():
	enable_zoning_mode()
	player.to_zone = 1
	selection_box.set_zone(1)
	activate_cost_box()

func _on_ArtisanButton_pressed():
	enable_zoning_mode()
	player.to_zone = 2
	selection_box.set_zone(2)
	activate_cost_box()

func _on_ArtisanHousingButton_pressed():
	enable_zoning_mode()
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

func _on_ZoneMenu_mouse_exited():
	emit_signal("mouse_exited_menu")

func _on_BulldozeButton_pressed():
	disable_zoning_mode()
	hide()
