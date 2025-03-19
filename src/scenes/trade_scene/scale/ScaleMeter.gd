extends Control


func rotateArrow(angle):
	var newAngle = (angle - $Arrow.rotation_degrees)/25
	var addAngle = newAngle
	$Arrow.rotation_degrees += addAngle;
	
	
	
	pass
	
