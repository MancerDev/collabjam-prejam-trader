extends Resource
class_name NamePickFrom

const NpcNameGenerator = preload("res://NPCs/npc_name_generator.gd")

@export_flags("Any", "AngloSaxon", "Germanic", "MedDutch", "MedEnglish", "MedFrench", "MedGerman", "OldIrish") var pick_from: int:
	set(value):
		if pick_from != value:
			pick_from = value
			#update_name_randomization()
			emit_changed()

#@export var gender: NpcNameGenerator.GenderOptions
@export var use_female_names: bool = true:
	set(value):
		if use_female_names != value:
			use_female_names = value
			#update_name_randomization()
			emit_changed()
@export var use_male_names: bool = true:
	set(value):
		if use_male_names != value:
			use_male_names = value
			#update_name_randomization()
			emit_changed()

var name_pick_sizes: PackedFloat32Array
var name_pick_indices: Array[Vector2i]

# use rand_wighted with array of the size of each origin specific array
# create array with sizes and array with indices for each name list

func update_name_randomization() -> void:
	var pick_from_modified = pick_from
	if pick_from & 0b0000_0001 > 0:
		pick_from_modified = 0b1111_1111
	if pick_from_modified & 0b0000_0010 > 0:
		if use_female_names:
			name_pick_sizes.append(NpcNameGenerator.res_anglo_saxon_f.count)
			name_pick_indices.append(Vector2i(0, 0))
		if use_male_names:
			name_pick_sizes.append(NpcNameGenerator.res_anglo_saxon_m.count)
			name_pick_indices.append(Vector2i(1, 0))
	if pick_from_modified & 0b0000_0100 > 0:
		if use_female_names:
			name_pick_sizes.append(NpcNameGenerator.res_germanic_f.count)
			name_pick_indices.append(Vector2i(0, 1))
		if use_male_names:
			name_pick_sizes.append(NpcNameGenerator.res_germanic_m.count)
			name_pick_indices.append(Vector2i(1, 1))
	if pick_from_modified & 0b0000_1000 > 0:
		if use_female_names:
			name_pick_sizes.append(NpcNameGenerator.res_medieval_dutch_f.count)
			name_pick_indices.append(Vector2i(0, 2))
		if use_male_names:
			name_pick_sizes.append(NpcNameGenerator.res_medieval_dutch_m.count)
			name_pick_indices.append(Vector2i(1, 2))
	if pick_from_modified & 0b0001_0000 > 0:
		if use_female_names:
			name_pick_sizes.append(NpcNameGenerator.res_medieval_english_f.count)
			name_pick_indices.append(Vector2i(0, 3))
		if use_male_names:
			name_pick_sizes.append(NpcNameGenerator.res_medieval_english_m.count)
			name_pick_indices.append(Vector2i(1, 3))
	if pick_from_modified & 0b0010_0000 > 0:
		if use_female_names:
			name_pick_sizes.append(NpcNameGenerator.res_medieval_french_f.count)
			name_pick_indices.append(Vector2i(0, 4))
		if use_male_names:
			name_pick_sizes.append(NpcNameGenerator.res_medieval_french_m.count)
			name_pick_indices.append(Vector2i(1, 4))
	if pick_from_modified & 0b0100_0000 > 0:
		if use_female_names:
			name_pick_sizes.append(NpcNameGenerator.res_medieval_german_f.count)
			name_pick_indices.append(Vector2i(0, 5))
		if use_male_names:
			name_pick_sizes.append(NpcNameGenerator.res_medieval_german_m.count)
			name_pick_indices.append(Vector2i(1, 5))
	if pick_from_modified & 0b1000_0000 > 0:
		if use_female_names:
			name_pick_sizes.append(NpcNameGenerator.res_old_irish_f.count)
			name_pick_indices.append(Vector2i(0, 6))
		if use_male_names:
			name_pick_sizes.append(NpcNameGenerator.res_old_irish_m.count)
			name_pick_indices.append(Vector2i(1, 6))

#func _ready() -> void:
	#update_name_randomization()
