extends ColorRect
signal mouse_entered_menu
signal mouse_exited_menu
var player
var current_production = {
	"grain": 0,
	"wood": 0,
	"stone": 0,
	"labor": 0,
	"copper": 0,
	"gold": 0,
	"tin": 0,
	"bronze": 0
}

func _ready():
	player = get_tree().root.get_node("Main/Player")
	update()

func update():
	for resource in current_production.keys():
		get_node("ResourceBoxes/" + resource.capitalize() + "/Value").text = str(floor(player.stockpile[resource]))
		if current_production[resource] >= 0:
			get_node("ResourceBoxes/" + resource.capitalize() + "/Production").text = "+"
			get_node("ResourceBoxes/" + resource.capitalize() + "/Production").modulate = Color(0.15, 0.89, 0.06)
		elif current_production[resource] < 0:
			get_node("ResourceBoxes/" + resource.capitalize() + "/Production").text = "-"
			get_node("ResourceBoxes/" + resource.capitalize() + "/Production").modulate = Color(0.89, 0.12, 0.33)
		get_node("ResourceBoxes/" + resource.capitalize() + "/Production").text += str(current_production[resource])

func _on_Player_update_resource_bar():
	update()

func _on_ResourceBar_mouse_entered():
	emit_signal("mouse_entered_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: True"


func _on_ResourceBar_mouse_exited():
	emit_signal("mouse_exited_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: False"


func _on_Buildings_production_updated(new_production):
	current_production = new_production
	update()
