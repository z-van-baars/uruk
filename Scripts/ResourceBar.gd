extends ColorRect
signal mouse_entered_menu
signal mouse_exited_menu
var player

func _ready():
	player = get_tree().root.get_node("Main/Player")
	update()

func update():
	$Grain.text = str(player.stockpile["grain"])
	$Wood.text = str(player.stockpile["wood"])
	$Stone.text = str(player.stockpile["stone"])
	$Labor.text = str(player.stockpile["labor"])
	$Copper.text = str(player.stockpile["copper"])
	$Gold.text = str(player.stockpile["gold"])
	$Tin.text = str(player.stockpile["tin"])
	$Bronze.text = str(player.stockpile["bronze"])

func _on_Player_update_resource_bar():
	update()

func _on_ResourceBar_mouse_entered():
	emit_signal("mouse_entered_menu")


func _on_ResourceBar_mouse_exited():
	emit_signal("mouse_exited_menu")
