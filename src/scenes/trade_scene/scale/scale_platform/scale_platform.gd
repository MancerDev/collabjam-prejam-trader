extends RigidBody2D

var weight = 0;
var nodes_on_scale = [];

func _physics_process(delta):
	weight = $Platform.weight;


func slow_platform_movement(target_point): 
	var newPos = (target_point - position).normalized() 
	#var addPos = newPos
	position += 0.1*newPos;
