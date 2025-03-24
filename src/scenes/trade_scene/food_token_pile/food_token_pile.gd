extends coin_pile




func _on_ready() -> void:
	storedObjectScript = food_token
	coin_scene = load("res://src/scenes/trade_scene/pickable/FoodToken/food_coin.tscn")
	
