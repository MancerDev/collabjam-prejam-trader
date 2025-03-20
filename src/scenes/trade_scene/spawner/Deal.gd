extends Button




func _on_button_down() -> void:
	print("Deal happens")
	
	for node in $"../Scale".SelfPlatform.currentCollidedBodies:
		print(node)
		node.queue_free()
		
	for node in $"../Scale".OtherPlatform.currentCollidedBodies:
		node.queue_free()
		$"../Button5"._on_button_down();
	#clicked.emit(self, get_meta("SpawnableObject"))
	pass 
