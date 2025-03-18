extends RigidBody2D

var weight = 0;

func _physics_process(delta):
	weight = 0;
	var allCollidedBodies = [];
	#
	#for body in get_colliding_bodies():
	#	allCollidedBodies.push_front(body);
	#	weight += body.mass;
	recursiveCollisionCheck(allCollidedBodies, get_colliding_bodies());
		
	allCollidedBodies.erase(self);
	for body in allCollidedBodies:
		weight += round_to_dec(body.mass, 3);
	
	$Label.text = str(weight)+"KG"


func recursiveCollisionCheck(allCollidedBodies, bodies):
	#var collidedBodies = [];
	for body in bodies:
		if (allCollidedBodies.count(body) == 0):
			allCollidedBodies.push_front(body);
			recursiveCollisionCheck(allCollidedBodies, body.get_colliding_bodies());

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
