extends Control
var zone_menu


func _ready():
	zone_menu = get_tree().root.get_node("Main/UILayer/ZoneMenu")


func _on_ZonesButton_pressed():
	print("pressed")
	print(zone_menu.visible)
	if zone_menu.visible == false:
		zone_menu.show()
	else:
		zone_menu.hide()
