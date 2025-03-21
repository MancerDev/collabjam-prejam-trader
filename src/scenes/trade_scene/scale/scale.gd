extends Node2D

var SelfPlatform 
var OtherPlatform 
var scalePlatformSelf_position_saved;
var scalePlatformOther_position_saved;
#var currentCollidedBodies

func _ready(): 
	SelfPlatform = $ScalePlatformSelf;
	OtherPlatform = $ScalePlatformOther;
	
	scalePlatformSelf_position_saved = $ScalePlatformSelf.position
	scalePlatformOther_position_saved = $ScalePlatformOther.position


func _physics_process(delta):
	var angle = 0;
	var currentWeightComparison = ($ScalePlatformSelf.weight+5) - ($ScalePlatformOther.weight+5)
	
	if (!($ScalePlatformSelf.weight == 0) and !($ScalePlatformOther.weight == 0)):
		if (currentWeightComparison > 0):
			angle = ($ScalePlatformSelf.weight / $ScalePlatformOther.weight)*5
		elif (currentWeightComparison < 0):
			angle = ($ScalePlatformOther.weight / $ScalePlatformSelf.weight)*-5
		var y_offset = angle;
		set_up_platforms_height(y_offset)
		$Control.rotateArrow(angle/2);



func set_up_platforms_height(y_offset):
	$ScalePlatformSelf.slow_platform_movement(scalePlatformSelf_position_saved + Vector2(0, y_offset))
	$ScalePlatformOther.slow_platform_movement(scalePlatformOther_position_saved + Vector2(0, -y_offset))
	
	
