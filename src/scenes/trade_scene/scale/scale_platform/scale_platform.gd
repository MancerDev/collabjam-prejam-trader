extends RigidBody2D

var weight = 0;

func _physics_process(delta):
	weight = $Platform.weight;


func slow_platform_movement(target_point): 
	var newPos = (target_point - position)/50
	var addPos = newPos
	position += addPos;
