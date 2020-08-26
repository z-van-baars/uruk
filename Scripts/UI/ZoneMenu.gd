extends Control

var selection_box
var player

func _ready():
	selection_box = get_tree().root.get_node("Main/WorldGen/SelectionBox")
	player = get_tree().root.get_node("Main/Player")

func enable_build_mode():
	selection_box.build_mode = true
	selection_box.show()
	player.build_mode = true
	player.emit_signal("update_dock")

func disable_build_mode():
	selection_box.build_mode = true
	selection_box.show()
	player.build_mode = true
	player.to_build = null
	player.emit_signal("update_dock")

func _on_FarmlandButton_pressed():
	enable_build_mode()
	player.to_build = 5


func _on_PoorHousingButton_pressed():
	enable_build_mode()
	player.to_build = 2

func _on_ArtisanButton_pressed():
	enable_build_mode()

func _on_ArtisanHousingButton_pressed():
	enable_build_mode()


func _on_NobleHousingButton_pressed():
	enable_build_mode()


func _on_ZonesButton_pressed():
	disable_build_mode()
