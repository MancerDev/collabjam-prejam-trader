extends artifact

var current_weight = 5;

func on_buy():
	var trade_scene = get_node("/root/SceneChangeSingleton/Scenes/Trade") 
	trade_scene.flat_bonus += 1;
	current_weight = 2
	pass

func _on_child_exiting_tree(node: Node) -> void:
	var trade_scene = get_node("/root/SceneChangeSingleton/Scenes/Trade") 
	trade_scene.flat_bonus -= 1;
	pass

func get_weight():
	return current_weight;
