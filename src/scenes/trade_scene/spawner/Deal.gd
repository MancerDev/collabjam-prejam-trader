extends Button

signal clicked


func _on_button_down() -> void:
	print("Deal happens")
	
	if deal_check():
		deal_execute()
	
	#clicked.emit(self, get_meta("SpawnableObject"))
	pass 
	

func deal_check():
	if $"../Scale".SelfPlatform.platform.weight >= $"../Scale".OtherPlatform.platform.weight:
		return true;
	else: 
		return false;



func deal_execute():
	
	for node in $"../Scale".SelfPlatform.platform.currentCollidedBodies:
		print(node)
		node.queue_free()
	
	for node in $"../Scale".OtherPlatform.platform.currentCollidedBodies:
		if (node.has_method("OnBuy")):
			node.OnBuy()
		node.queue_free()
		
	
