extends Node2D

onready var player = get_tree().root.get_node("Main/Player")
onready var buildings = get_tree().root.get_node("Main/Buildings")

func _process(delta):
	hide()
	if player.to_build != null:
		show()
		set_cost_label(buildings.get_cost(player.to_build))

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
	$CostBacking.rect_size = Vector2(100, 2 + cost_count * 20)
	show()
