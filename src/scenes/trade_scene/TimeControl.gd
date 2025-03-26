extends Control

func TimeUpdate(hour, customers):
	$Time.text = str(hour)+":00";
	$Customers.text = "Customers 
		left:"+str(customers)
		
	if (hour > 20):
		$"../../Uninterractables/NightBackground".show()
		$"../../Uninterractables/DayBackground".hide()
	else:
		$"../../Uninterractables/NightBackground".hide()
		$"../../Uninterractables/DayBackground".show()
	pass
	
