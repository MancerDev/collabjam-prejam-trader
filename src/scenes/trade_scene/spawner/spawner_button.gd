extends Button

signal clicked

			
			#update_quantity(quantity - 1)
#
#func _on_button_down() -> void:
	#var scene =.instantiate();
	#var object = scene;
	#self.clicked.connect()
	#add_child(object);
	#pass # Replace with function body.


func _on_button_down() -> void:
	clicked.emit(self, get_meta("SpawnableObject"))
	pass 
