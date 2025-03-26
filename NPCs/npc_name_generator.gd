extends Node

#enum GenderOptions {
	#Female, Male, Neutral
#}

const res_anglo_saxon_f      : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/f_anglo_saxon.tres")
const res_germanic_f         : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/f_germanic.tres")
const res_medieval_dutch_f   : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/f_medieval_dutch.tres")
const res_medieval_english_f : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/f_medieval_english.tres")
const res_medieval_french_f  : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/f_medieval_french.tres")
const res_medieval_german_f  : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/f_medieval_german.tres")
const res_old_irish_f        : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/f_old_irish.tres")

const res_anglo_saxon_m      : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/m_anglo_saxon.tres")
const res_germanic_m         : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/m_germanic.tres")
const res_medieval_dutch_m   : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/m_medieval_dutch.tres")
const res_medieval_english_m : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/m_medieval_english.tres")
const res_medieval_french_m  : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/m_medieval_french.tres")
const res_medieval_german_m  : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/m_medieval_german.tres")
const res_old_irish_m        : NPCFirstnameList = preload("res://NPCs/behindthename name extraction/first names/m_old_irish.tres")

# would need to recalculate cumulative indices on a change, so im just going to put them all together for now
#var use_anglo_saxon      : bool = true
#var use_germanic         : bool = true
#var use_medieval_english : bool = true
#var use_medieval_french  : bool = true
#var use_old_irish        : bool = true

var names_cumulative_indices_f: Array[int]
var names_cumulative_indices_m: Array[int]

#var rng = RandomNumberGenerator.new()


func _ready() -> void:
	#var template_names_resource: NPCFirstnameList = NPCFirstnameList.new()
	#template_names_resource.firstnames = ["foo", "bar", "bat", "0123456789012345678901234567890123456789_0123456789012345678901234567890123456789_0123456789012345678901234567890123456789_0123456789012345678901234567890123456789___0123456789012345678901234567890123456789_0123456789012345678901234567890123456789_0123456789012345678901234567890123456789_0123456789012345678901234567890123456789"]
	#template_names_resource.meanings = ["foo is a classic generic name for a variable", "as is bar", "bat however seems at least a bit derivative", "and lastly a test for a very long string, it is a very long 'name' made from the numbers, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, in that order, copied 4 times, then an underscore is appended as a separator. that is then copied four times, with at the end it having three underscores in total. this is then copied and appended, but at the end it does not have any trailing underscores. this is not meaningful data but it's important to test with extremes so that your test is more representative of the actual data. this description or meaning is probably more than long enough, so i will end it here."]
	#ResourceSaver.save(template_names_resource, "res://NPCs/behindthename name extraction/template_names_resource.tres")
	
	names_cumulative_indices_f.append(0)
	names_cumulative_indices_f.append(res_anglo_saxon_f.count)
	names_cumulative_indices_f.append(names_cumulative_indices_f[1] + res_germanic_f.count)
	names_cumulative_indices_f.append(names_cumulative_indices_f[2] + res_medieval_dutch_f.count)
	names_cumulative_indices_f.append(names_cumulative_indices_f[3] + res_medieval_english_f.count)
	names_cumulative_indices_f.append(names_cumulative_indices_f[4] + res_medieval_french_f.count)
	names_cumulative_indices_f.append(names_cumulative_indices_f[5] + res_medieval_german_f.count)
	names_cumulative_indices_f.append(names_cumulative_indices_f[6] + res_old_irish_f.count) # total
	
	names_cumulative_indices_m.append(0)
	names_cumulative_indices_m.append(res_anglo_saxon_m.count)
	names_cumulative_indices_m.append(names_cumulative_indices_m[1] + res_germanic_m.count)
	names_cumulative_indices_m.append(names_cumulative_indices_m[2] + res_medieval_dutch_m.count)
	names_cumulative_indices_m.append(names_cumulative_indices_m[3] + res_medieval_english_m.count)
	names_cumulative_indices_m.append(names_cumulative_indices_m[4] + res_medieval_french_m.count)
	names_cumulative_indices_m.append(names_cumulative_indices_m[5] + res_medieval_german_m.count)
	names_cumulative_indices_m.append(names_cumulative_indices_m[6] + res_old_irish_m.count) # total
	
	#print(res_anglo_saxon_f.count, " ", res_germanic_f.count, " ", res_medieval_dutch_f.count, " ", res_medieval_english_f.count, " ", res_medieval_french_f.count, " ", res_medieval_german_f.count, " ", res_old_irish_f.count)
	#print(res_anglo_saxon_m.count, " ", res_germanic_m.count, " ", res_medieval_dutch_m.count, " ", res_medieval_english_m.count, " ", res_medieval_french_m.count, " ", res_medieval_german_m.count, " ", res_old_irish_m.count)
	#
	#print(names_cumulative_indices_f)
	#print(names_cumulative_indices_m)
	#
	#for i in range(0, 20):
		#print(pickname_f())
	#print()
	#for i in range(0, 20):
		#print(pickname_m())


static func pickname_size_weighted_arrays(rng: RandomNumberGenerator, sizes: PackedFloat32Array, indices: Array[Vector2i]) -> String:
	var weighted_select = rng.rand_weighted(sizes)
	var index_in_selected = rng.randi_range(0, sizes[weighted_select])
	if indices[weighted_select].x == 0:
		if   indices[weighted_select].y == 0: return res_anglo_saxon_f     .firstnames[index_in_selected]
		elif indices[weighted_select].y == 1: return res_germanic_f        .firstnames[index_in_selected]
		elif indices[weighted_select].y == 2: return res_medieval_dutch_f  .firstnames[index_in_selected]
		elif indices[weighted_select].y == 3: return res_medieval_english_f.firstnames[index_in_selected]
		elif indices[weighted_select].y == 4: return res_medieval_french_f .firstnames[index_in_selected]
		elif indices[weighted_select].y == 5: return res_medieval_german_f .firstnames[index_in_selected]
		elif indices[weighted_select].y == 6: return res_old_irish_f       .firstnames[index_in_selected]
	elif indices[weighted_select].x == 1:
		if   indices[weighted_select].y == 0: return res_anglo_saxon_m     .firstnames[index_in_selected]
		elif indices[weighted_select].y == 1: return res_germanic_m        .firstnames[index_in_selected]
		elif indices[weighted_select].y == 2: return res_medieval_dutch_m  .firstnames[index_in_selected]
		elif indices[weighted_select].y == 3: return res_medieval_english_m.firstnames[index_in_selected]
		elif indices[weighted_select].y == 4: return res_medieval_french_m .firstnames[index_in_selected]
		elif indices[weighted_select].y == 5: return res_medieval_german_m .firstnames[index_in_selected]
		elif indices[weighted_select].y == 6: return res_old_irish_m       .firstnames[index_in_selected]
	return "Erminsculda (great error)"


func index_in_subrange(randint: int, splits: Array[int]) -> Vector2i:
	if randint < splits[1]:
		return Vector2i(0, randint)
	elif randint < splits[2]:
		return Vector2i(1, randint - splits[1])
	elif randint < splits[3]:
		return Vector2i(2, randint - splits[2])
	elif randint < splits[4]:
		return Vector2i(3, randint - splits[3])
	elif randint < splits[5]:
		return Vector2i(4, randint - splits[4])
	elif randint < splits[6]:
		return Vector2i(5, randint - splits[5])
	elif randint < splits[7]:
		return Vector2i(6, randint - splits[6])
	else:
		return Vector2i(-1, -1)

func pickname_f() -> String:
	var randint = randi_range(0, names_cumulative_indices_f[6] - 1)
	var split = index_in_subrange(randint, names_cumulative_indices_f)
	if split.x == 0:
		return res_anglo_saxon_f.firstnames[split.y]
	if split.x == 1:
		return res_germanic_f.firstnames[split.y]
	if split.x == 2:
		return res_medieval_dutch_f.firstnames[split.y]
	if split.x == 3:
		return res_medieval_english_f.firstnames[split.y]
	if split.x == 4:
		return res_medieval_french_f.firstnames[split.y]
	if split.x == 5:
		return res_medieval_german_f.firstnames[split.y]
	if split.x == 6:
		return res_old_irish_f.firstnames[split.y]
	else:
		return "Erminsculda (great error)"

func pickname_m() -> String:
	var randint = randi_range(0, names_cumulative_indices_m[6] - 1)
	var split = index_in_subrange(randint, names_cumulative_indices_m)
	if split.x == 0:
		return res_anglo_saxon_m.firstnames[split.y]
	if split.x == 1:
		return res_germanic_m.firstnames[split.y]
	if split.x == 2:
		return res_medieval_dutch_m.firstnames[split.y]
	if split.x == 3:
		return res_medieval_english_m.firstnames[split.y]
	if split.x == 4:
		return res_medieval_french_m.firstnames[split.y]
	if split.x == 5:
		return res_medieval_german_m.firstnames[split.y]
	if split.x == 6:
		return res_old_irish_m.firstnames[split.y]
	else:
		return "Erminsculd (great error)"
