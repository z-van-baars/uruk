extends Control
signal mouse_entered_menu
signal mouse_exited_menu
var zone_menu
var boosters_menu
var harvesters_menu
var processors_menu
var selection_box

func _ready():
	zone_menu = get_tree().root.get_node("Main/UILayer/ZoneMenu")
	boosters_menu = get_tree().root.get_node("Main/UILayer/BoostersMenu")
	harvesters_menu = get_tree().root.get_node("Main/UILayer/HarvestersMenu")
	processors_menu = get_tree().root.get_node("Main/UILayer/ProcessorsMenu")
	selection_box = get_tree().root.get_node("Main/WorldGen/SelectionBox")

func hide_all_submenus():
	for submenu in [
		zone_menu,
		boosters_menu,
		harvesters_menu,
		processors_menu]:
		submenu.hide()

func enable_bulldoze_mode():
	pass

func enable_build_mode():
	selection_box.build_mode = true
	selection_box.activate_build_sprite()

func _on_BuildWidget_mouse_entered():
	emit_signal("mouse_entered_menu")


func _on_BuildWidget_mouse_exited():
	emit_signal("mouse_exited_menu")


func _on_ZonesButton_pressed():
	var reopen = !zone_menu.visible
	hide_all_submenus()
	if reopen == true:
		zone_menu.show()

func _on_BoostersButton_pressed():
	var reopen = !boosters_menu.visible
	hide_all_submenus()
	if reopen == true:
		boosters_menu.show()

func _on_HarvestersButton_pressed():
	var reopen = !harvesters_menu.visible
	hide_all_submenus()
	if reopen == true:
		harvesters_menu.show()

func _on_ProcessorsButton_pressed():
	var reopen = !processors_menu.visible
	hide_all_submenus()
	if reopen == true:
		processors_menu.show()

func _on_BulldozeButton_pressed():
	hide_all_submenus()
	enable_bulldoze_mode()
