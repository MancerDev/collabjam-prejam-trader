extends Node2D

@export var npc : Resource

var sprite : Sprite2D
var label : Label

func _ready():
	if npc:
		sprite = %Sprite2D
		sprite.texture = npc.sprite_neutral  
	
		set_sprite_state("neutral")

func set_sprite_state(state: String):
	match state:
		"happy":
			sprite.texture = npc.sprite_happy
		"angry":
			sprite.texture = npc.sprite_angry
		_:
			sprite.texture = npc.sprite_neutral
