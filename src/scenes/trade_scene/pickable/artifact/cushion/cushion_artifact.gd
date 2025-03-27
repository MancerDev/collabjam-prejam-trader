extends artifact


func get_weight():
	var bodies = get_colliding_bodies()
	
	if (bodies.size() == 2):
		return 5;
	else:
		return 0;
