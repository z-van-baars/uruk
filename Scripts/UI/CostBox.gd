extends Node2D

func _process(delta):
	position = get_viewport().get_mouse_position()
	position = get_viewport().get_canvas_transform().xform_inv(position)

func reset_cost_label():
	$CostBacking.rect_size = Vector2(120, 22)
	$CostLabel.text = ""
	hide()

func set_cost_label(total_cost):
	reset_cost_label()
	var cost_count = 0
	for resource in total_cost.keys():
		$CostLabel.text += str(total_cost[resource]) + "  " + resource + "\n"
		cost_count += 1
	$CostBacking.rect_size = Vector2(120, 2 + cost_count * 20)
	show()
