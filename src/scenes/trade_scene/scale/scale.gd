extends Node2D

func _physics_process(delta):
	var angle = 0;
	var currentWeightComparison = $ScalePlatformSelf.weight - $ScalePlatformOther.weight
	if (!($ScalePlatformSelf.weight == 0) and !($ScalePlatformOther.weight == 0)):
		if (currentWeightComparison > 0):
			angle = ($ScalePlatformSelf.weight / $ScalePlatformOther.weight)*5
		elif (currentWeightComparison < 0):
			angle = ($ScalePlatformOther.weight / $ScalePlatformSelf.weight)*-5
		
	$Control.rotateArrow(angle);
