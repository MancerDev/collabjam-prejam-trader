extends Node2D

enum MusicSelection {
	None,
	Menu,
	Day,
	Night
}

var start_menu_scene = preload("res://src/scenes/start_menu_scene/start_menu_scene.tscn")
var trade_scene = preload("res://src/scenes/trade_scene/trade.tscn")
var credits_scene
var animation_time = 1.5
var scene_change_delay = 0.5
var music_playing: MusicSelection
var music_next: MusicSelection

@export_range(10.0, 20500.0, 0.1, "exp") var lowpass_cutoff: float:
	set(value):
		lowpass_cutoff = value
		AudioServer.get_bus_effect(AudioServer.get_bus_index("Music"), 0).cutoff_hz = value

@export_range(10.0, 20500.0, 0.1, "exp") var highpass_cutoff: float:
	set(value):
		highpass_cutoff = value
		AudioServer.get_bus_effect(AudioServer.get_bus_index("Music"), 1).cutoff_hz = value

@onready var music_filter: AnimationPlayer = $music_filter
@onready var music_fade_out: AnimationPlayer = $music_fade_out
@onready var music_fade_in: AnimationPlayer = $music_fade_in
@onready var music_menu: AudioStreamPlayer = $music_menu
@onready var music_day: AudioStreamPlayer = $music_day
@onready var music_night: AudioStreamPlayer = $music_night

# Called when the node enters the scene tree for the first time.
func _ready():
	# Instantiate the Start Menu scene
	SceneChangeSingleton.music_playing = SceneChangeSingleton.MusicSelection.None
	SceneChangeSingleton.music_next = SceneChangeSingleton.MusicSelection.Menu
	openScene(start_menu_scene)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func openScene(scene):
	$ColorRect.visible = true
	
	var music_anim_time = 1 / (animation_time + scene_change_delay)
	var fade_out_anim = ""
	var fade_in_anim = ""
	if music_playing != music_next:
		if music_playing == MusicSelection.Menu: fade_out_anim = "fade_out_menu"
		elif music_playing == MusicSelection.Day: fade_out_anim = "fade_out_day"
		elif music_playing == MusicSelection.Night: fade_out_anim = "fade_out_night"
		if music_next == MusicSelection.Menu: fade_in_anim = "fade_in_menu"
		elif music_next == MusicSelection.Day: fade_in_anim = "fade_in_day"
		elif music_next == MusicSelection.Night: fade_in_anim = "fade_in_night"

		#music_filter.play("filter_out", -1, music_anim_time)
		#music_filter.play("filter_bounce", -1, music_anim_time * 0.5)
		if music_playing != MusicSelection.None:
			music_fade_out.play(fade_out_anim, -1, music_anim_time)
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate:a", 1, animation_time)
	await tween.finished
	# Remove all existing children
	for child in $Scenes.get_children():
		child.queue_free()
	

	var scene_instance = scene.instantiate()

	if music_playing != music_next:
		if music_next != MusicSelection.None:
			music_fade_in.play(fade_in_anim, -1, music_anim_time)
		if music_next == MusicSelection.Menu: music_menu.playing = true
		elif music_next == MusicSelection.Day: music_day.playing = true
		elif music_next == MusicSelection.Night: music_night.playing = true
	$Timer.start(scene_change_delay * 0.5)
	await $Timer.timeout
		#music_filter.play("filter_out", -1, -music_anim_time, true)
	$Timer.start(scene_change_delay * 0.5)
	await $Timer.timeout
	$Scenes.add_child(scene_instance)

	tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0, animation_time)
	await tween.finished
	$ColorRect.visible = false
	if music_playing != music_next:
		if music_playing == MusicSelection.Menu: music_menu.playing = false
		elif music_playing == MusicSelection.Day: music_day.playing = false
		elif music_playing == MusicSelection.Night: music_night.playing = false
		music_playing = music_next
		music_next = MusicSelection.None
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
