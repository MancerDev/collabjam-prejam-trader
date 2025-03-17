extends RigidBody2D


func _physics_process(delta):
	var weight = 0;
	var allCollidedBodies = [];
	#
	#for body in get_colliding_bodies():
	#	allCollidedBodies.push_front(body);
	#	weight += body.mass;
	recursiveCollisionCheck(allCollidedBodies, get_colliding_bodies());
		
	allCollidedBodies.erase(self);
	for body in allCollidedBodies:
		weight += body.mass;
	
	$Label.text = str(weight)+"KG"


func recursiveCollisionCheck(allCollidedBodies, bodies):
	#var collidedBodies = [];
	for body in bodies:
		if (allCollidedBodies.count(body) == 0):
			allCollidedBodies.push_front(body);
			recursiveCollisionCheck(allCollidedBodies, body.get_colliding_bodies());
