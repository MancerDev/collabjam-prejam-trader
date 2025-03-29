extends Node2D

func _ready():
	$Cart.play("default")
	$Control/Panel2.hide()


func _on_start_button_pressed() -> void:
	SceneChangeSingleton.music_next = SceneChangeSingleton.MusicSelection.Day
	SceneChangeSingleton.openTradeScene()
	SfxSingleton.play_sound("open_door")


func _on_credits_button_pressed() -> void:
	$Control/Panel2.show()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	$Control/Panel2.hide()
	pass # Replace with function body.
