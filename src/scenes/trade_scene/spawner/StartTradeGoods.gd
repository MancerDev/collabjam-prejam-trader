extends "res://src/scenes/trade_scene/spawner/spawner_button.gd"



func _on_button_down() -> void:
	clear_goods()
	print("clicked")
	var weight = preload("res://src/scenes/trade_scene/pickable/weight/weight.tscn")
	clicked.emit(self, weight, set_up_weight_values)
	var weight2 = preload("res://src/scenes/trade_scene/pickable/weight/weight.tscn")
	clicked.emit(self, weight2, set_up_weight_values)
	pass 


func set_up_weight_values(spawner, weight):
	weight.WeightSetUp(floor(randf()*3+1), 1)
	weight.add_to_group("customer_goods")
	#weight.


func clear_goods():
	for node in get_tree().get_nodes_in_group("customer_goods"):
		node.queue_free()
