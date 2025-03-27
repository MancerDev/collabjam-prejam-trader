extends DragabbleObject

class_name coin


func _on_body_entered(body: Node) -> void:
	SfxSingleton.play_sound("gold_coin_drop")
