extends Control

func _ready():
	$"../../Uninterractables/NightBackground".show()
	$"../../Uninterractables/DayBackground".show()
	var tween = create_tween()
	tween.tween_property($"../../Uninterractables/NightBackground", "modulate:a", 0.0, 0)
	tween.tween_property($"../../Uninterractables/DayBackground", "modulate:a", 1.0, 0)
	

func TimeUpdate(hour, customers, day = 0):
	var SceneChangeSingleton = get_node("/root/SceneChangeSingleton") 
	$Time.text = str(hour)+":00";
	$Customers.text = "Customers:"+str(customers)
	$Day.text = "Day:"+str(day)
	var tween = create_tween()
	if (hour > 20):
		#$"../../Uninterractables/NightBackground".show()
		SceneChangeSingleton.music_next = SceneChangeSingleton.MusicSelection.Night
		tween.tween_property($"../../Uninterractables/NightBackground", "modulate:a", 1.0, 1)
		tween.tween_property($"../../Uninterractables/DayBackground", "modulate:a", 0.0, 1)
	else:
		SceneChangeSingleton.music_next = SceneChangeSingleton.MusicSelection.Day
		tween.tween_property($"../../Uninterractables/DayBackground", "modulate:a", 1.0, 1)
		tween.tween_property($"../../Uninterractables/NightBackground", "modulate:a", 0.0, 1)
	pass
	
