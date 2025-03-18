extends RigidBody2D

var weight = 0;

func _physics_process(delta):
	weight = $Platform.weight;
