extends Control

func _ready():
	$"../../Uninterractables/NightBackground".show()
	$"../../Uninterractables/DayBackground".show()
	var tween = create_tween()
	tween.tween_property($"../../Uninterractables/NightBackground", "modulate:a", 0.0, 0)
	tween.tween_property($"../../Uninterractables/DayBackground", "modulate:a", 1.0, 0)
	

func TimeUpdate(hour, customers):
	$Time.text = str(hour)+":00";
	$Customers.text = "Customers 
		left:"+str(customers)
	var tween = create_tween()
	
	
	if (hour > 20):
		#$"../../Uninterractables/NightBackground".show()
		tween.tween_property($"../../Uninterractables/NightBackground", "modulate:a", 1.0, 1)
		tween.tween_property($"../../Uninterractables/DayBackground", "modulate:a", 0.0, 1)
	else:
		tween.tween_property($"../../Uninterractables/NightBackground", "modulate:a", 0.0, 1)
		tween.tween_property($"../../Uninterractables/DayBackground", "modulate:a", 1.0, 1)
	pass
	
