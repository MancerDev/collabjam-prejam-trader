extends Button



func _on_button_down() -> void:
	var scene = get_meta("SpawnableObject").instantiate();
	var object = scene;
	add_child(object);
	pass # Replace with function body.
