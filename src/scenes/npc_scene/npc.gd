extends Node2D

@export var resource : Resource

var sprite : Sprite2D
var label : Label

func _ready():
	if resource:
		sprite = %Sprite2D	
		set_sprite_state("neutral")

func set_sprite_state(state: String):
	match state:
		"happy":
			sprite.texture = resource.sprite_happy
		"angry":
			sprite.texture = resource.sprite_angry
		"back":
			sprite.texture = resource.sprite_back
		"sad":
			sprite.texture = resource.sprite_sad
		_:
			sprite.texture = resource.sprite_neutral
