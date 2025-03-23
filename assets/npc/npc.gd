extends Resource
class_name NPC
@export var name_origin: Name.Origins

@export var sprite_neutral: Texture2D
@export var sprite_happy: Texture2D
@export var sprite_angry: Texture2D
@export var sprite_back: Texture2D
@export var sprite_sad: Texture2D

@export var currency_map: CurrencyMap
@export var inventory: Dictionary[String, int] = {}

# probably some vars to indicate their happiness and anger tresholds
