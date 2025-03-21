extends coin_pile


func _on_ready() -> void:
	coin_scene = load("res://src/scenes/trade_scene/pickable/MetalToken/MetalToken.tscn")
	storedObjectScript = metal_token
