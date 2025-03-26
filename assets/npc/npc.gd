extends Resource
class_name NPC

const NpcNameGenerator = preload("res://NPCs/npc_name_generator.gd")

@export var name_pick_from: NamePickFrom
#@export_custom(PROPERTY_HINT_NONE, "", PROPERTY_USAGE_STORAGE + PROPERTY_USAGE_EDITOR + PROPERTY_USAGE_READ_ONLY + PROPERTY_USAGE_RESOURCE_NOT_PERSISTENT) var name: String
var name

@export var sprite_neutral: Texture2D
@export var sprite_happy: Texture2D
@export var sprite_angry: Texture2D
@export var sprite_back: Texture2D
@export var sprite_sad: Texture2D

@export var currency_map: CurrencyMap
@export var inventory: Dictionary[String, int] = {}

# probably some vars to indicate their happiness and anger tresholds

#var rng = RandomNumberGenerator.new()

#func _name_pick_from_updated() -> void:
	#name_pick_from.update_name_randomization()
	#name = NpcNameGenerator.pickname_size_weighted_arrays(rng, name_pick_from.name_pick_sizes, name_pick_from.name_pick_indices)

#func _ready() -> void:
	#rng.randomize()
	#name_pick_from.changed.connect(_name_pick_from_updated)
	#_name_pick_from_updated()
