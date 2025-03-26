extends Node2D

# Dictionary to hold sound streams
var sound_dict = {
	"open_door": preload("res://assets/sfx/open_door.ogg"),
	"close_door": preload("res://assets/sfx/close_door.ogg"),
	"silver_coin_drop": preload("res://assets/sfx/silver_coin_drop.ogg"),
	"silver_coin_pick_and_hit": preload("res://assets/sfx/silver_coin_pick_and_hit.ogg"),
	"gold_coin_drop": preload("res://assets/sfx/gold_coin_drop.ogg"),
	"gold_coin_pick_and_hit": preload("res://assets/sfx/gold_coin_pick_and_hit.ogg"),
	"fake_silver_coin_drop": preload("res://assets/sfx/fake_silver_coin_drop.ogg"),
	"fake_gold_coin_drop": preload("res://assets/sfx/fake_gold_coin_drop.ogg"),
	"tax_paper": preload("res://assets/sfx/tax_paper.ogg"),
	"corvidae_entry": preload("res://assets/sfx/corvidae_entry.ogg"),
	"entry_walk": preload("res://assets/sfx/entry_walk.ogg"),
	"gibberish_talk": preload("res://assets/sfx/gibberish_talk.ogg")
}

# Reference to the AudioStreamPlayer node
@onready var audio_player = $AudioStreamPlayer2D

# Function to play sound based on context
func play_sound(action):
	if action in sound_dict:
		audio_player.stream = sound_dict[action]
		audio_player.play()
	else:
		print("Sound not found for action: ", action)
