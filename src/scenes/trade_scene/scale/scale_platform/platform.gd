extends RigidBody2D

var weight = 0;
var currentCollidedBodies = [];

func _physics_process(delta):
	weight = 0;
	var allCollidedBodies = [];
	recursiveCollisionCheck(allCollidedBodies, get_colliding_bodies());
		
	allCollidedBodies.erase(self);
	currentCollidedBodies = allCollidedBodies;
	
	# Get the current NPC from the trade scene
	var trade_scene = get_node("/root/Trade")
	if !trade_scene:
		return
	var npc = trade_scene.get_node_or_null("Uninterractables/Npc")
	
	for body in allCollidedBodies:
		if body is coin and npc and npc.resource and npc.resource.currency_map:
			var currency_value = npc.resource.currency_map.currency_to_int_map.get(body.identifier, 0)
			weight += currency_value
		else:
			weight += round_to_dec(body.mass, 3)
		
	
	weight = round_to_dec(weight, 3)
	$Label.text = str(weight)+"KG"

func recursiveCollisionCheck(allCollidedBodies, bodies):
	for body in bodies:
		if (allCollidedBodies.count(body) == 0):
			allCollidedBodies.push_front(body);
			# Only check for more collisions if the body is a RigidBody2D
			if body is RigidBody2D and body.contact_monitor:
				recursiveCollisionCheck(allCollidedBodies, body.get_colliding_bodies());

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
