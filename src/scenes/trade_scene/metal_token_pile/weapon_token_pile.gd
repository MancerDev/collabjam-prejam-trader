extends coin_pile




func _on_ready() -> void:
	storedObjectScript = weapon_token
	coin_scene = load("res://src/scenes/trade_scene/pickable/WeaponToken/WeaponToken.tscn")
	
