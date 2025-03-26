extends Node2D

func _ready():
	$Cart.play("default")


func _on_start_button_pressed() -> void:
	SceneChangeSingleton.openTradeScene()
	SfxSingleton.play_sound("open_door")


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.
