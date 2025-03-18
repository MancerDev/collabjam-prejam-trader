extends Node


func _ready() -> void:
	var template_names_resource: NPCFirstnameList = NPCFirstnameList.new()
	template_names_resource.firstnames = ["foo", "bar", "bat", "0123456789012345678901234567890123456789_0123456789012345678901234567890123456789_0123456789012345678901234567890123456789_0123456789012345678901234567890123456789___0123456789012345678901234567890123456789_0123456789012345678901234567890123456789_0123456789012345678901234567890123456789_0123456789012345678901234567890123456789"]
	template_names_resource.meanings = ["foo is a classic generic name for a variable", "as is bar", "bat however seems at least a bit derivative", "and lastly a test for a very long string, it is a very long 'name' made from the numbers, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, in that order, copied 4 times, then an underscore is appended as a separator. that is then copied four times, with at the end it having three underscores in total. this is then copied and appended, but at the end it does not have any trailing underscores. this is not meaningful data but it's important to test with extremes so that your test is more representative of the actual data. this description or meaning is probably more than long enough, so i will end it here."]
	ResourceSaver.save(template_names_resource, "res://NPCs/behindthename name extraction/template_names_resource.tres")
	#pass
