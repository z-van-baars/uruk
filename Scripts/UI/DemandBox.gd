extends Control
var player

var bar_reference
var value_reference
signal mouse_entered_menu
signal mouse_exited_menu


func _ready():
	player = get_tree().root.get_node("Main/Player")
	bar_reference = {
		"farmland": $BarContainer/FarmlandBar,
		"slums": $BarContainer/SlumsBar,
		"artisan": $BarContainer/ArtisanBar,
		"artisan housing": $BarContainer/ArtisanHousingBar,
		"noble housing": $BarContainer/NobleHousingBar}
	value_reference = {
		"farmland": $ValueContainer/FarmValue,
		"slums": $ValueContainer/SlumsValue,
		"artisan": $ValueContainer/ArtisanValue,
		"artisan housing": $ValueContainer/ArtisanHousingValue,
		"noble housing": $ValueContainer/NobleHousingValue}
	update_bars()


func _input(event):
	if event.is_action_pressed("demand_values_toggle"):
		$ValueContainer.visible = !$ValueContainer.visible
		

func update_bars(unmet_demand={}):
	for each in unmet_demand:
		bar_reference[each].rect_size = Vector2(180, 16)
		bar_reference[each].value = unmet_demand[each]
		value_reference[each].text = str(unmet_demand[each])
		


func _on_Buildings_demand_updated(unmet_demand):
	update_bars(unmet_demand)


func _on_DemandBox_mouse_entered():
	emit_signal("mouse_entered_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: True"


func _on_DemandBox_mouse_exited():
	emit_signal("mouse_exited_menu")
	get_tree().root.get_node("Main/UILayer/MenuDetector").text = "Mouse in Menu: False"
