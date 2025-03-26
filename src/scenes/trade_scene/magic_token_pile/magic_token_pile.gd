extends coin_pile




func _on_ready() -> void:
	storedObjectScript = magic_token
	coin_scene = load("res://src/scenes/trade_scene/pickable/MagicToken/MagicToken.tscn")
	
