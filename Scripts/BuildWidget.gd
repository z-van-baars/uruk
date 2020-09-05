extends Control
signal mouse_entered_menu
signal mouse_exited_menu
onready var boosters_menu = get_tree().root.get_node("Main/UILayer/BoostersMenu")
onready var harvesters_menu = get_tree().root.get_node("Main/UILayer/HarvestersMenu")
onready var processors_menu = get_tree().root.get_node("Main/UILayer/ProcessorsMenu")
onready var selection_box = get_tree().root.get_node("Main/WorldGen/SelectionBox")
onready var build_cursor = get_tree().root.get_node("Main/BuildCursor")
onready var player = get_tree().root.get_node("Main/Player")


func hide_all_submenus():
	disable_build_mode()
	for submenu in [
		boosters_menu,
		harvesters_menu,
		processors_menu]:
		submenu.hide()

func enable_bulldoze_mode():
	pass

func enable_build_mode():
	player.build_mode = true
	selection_box.build_mode = true

func disable_build_mode():
	player.build_mode = false
	player.to_build = null

func _on_BuildWidget_mouse_entered():
	emit_signal("mouse_entered_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: True"


func _on_BuildWidget_mouse_exited():
	emit_signal("mouse_exited_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: False"


func _on_ZonesButton_pressed():
	return

func _on_BoostersButton_pressed():
	var reopen = !boosters_menu.visible
	hide_all_submenus()
	if reopen == true:
		enable_build_mode()
		boosters_menu.show()

func _on_HarvestersButton_pressed():
	var reopen = !harvesters_menu.visible
	hide_all_submenus()
	if reopen == true:
		enable_build_mode()
		harvesters_menu.show()

func _on_ProcessorsButton_pressed():
	var reopen = !processors_menu.visible
	hide_all_submenus()
	if reopen == true:
		enable_build_mode()
		processors_menu.show()

func _on_BulldozeButton_pressed():
	hide_all_submenus()
	enable_bulldoze_mode()
