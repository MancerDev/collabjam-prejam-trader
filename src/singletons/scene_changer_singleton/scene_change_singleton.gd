extends Node2D
var start_menu_scene = preload("res://src/scenes/start_menu_scene/start_menu_scene.tscn")
var trade_scene = preload("res://src/scenes/trade_scene/trade.tscn")
var credits_scene
var animation_time = 0.2
var scene_change_delay = 0.2
# Called when the node enters the scene tree for the first time.
func _ready():
	# Instantiate the Start Menu scene
	openScene(start_menu_scene)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func openScene(scene):
	$ColorRect.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate:a", 1, animation_time)
	await tween.finished
	# Remove all existing children
	for child in  $Scenes.get_children():
		child.queue_free()
	

	var scene_instance = scene.instantiate()

	$Timer.start(scene_change_delay)
	await $Timer.timeout
	$Scenes.add_child(scene_instance)

	tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0, animation_time)
	await tween.finished
	$ColorRect.visible = false
	return scene_instance

func openTradeScene():
	openScene(trade_scene)

func openCreditsScene():
	pass

func openStartMenuScene():
	openScene(start_menu_scene)


func add_overlay(scene):
	scene.z_index = 1000
	$Scenes.add_child(scene)
