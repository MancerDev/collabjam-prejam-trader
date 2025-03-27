extends artifact



func get_weight():
	var bodies = get_colliding_bodies()
	print(bodies.size()*1)
	return (5 - 1.2*(bodies.size()-1));
