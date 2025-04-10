extends RigidBody2D

var weight = 0;
var currentCollidedBodies = [];
#var playerSide = false;
var playerSide

func _physics_process(delta):
	weight = 0;
	var allCollidedBodies = [];
	recursiveCollisionCheck(allCollidedBodies, get_colliding_bodies());
		
	allCollidedBodies.erase(self);
	currentCollidedBodies = allCollidedBodies;
	
	# Get the current NPC from the trade scene
	var trade_scene = get_node("/root/SceneChangeSingleton/Scenes/Trade") 

	if !trade_scene:
		return
	var npc = trade_scene.get_node_or_null("Uninterractables/Npc")
	
	for body in allCollidedBodies:
		if body.is_in_group("pickable"):
			if (body.identifier == "weapon_coin" ||
			body.identifier == "silver_coin" ||  
			body.identifier == "food_coin" || 
			body.identifier == "magic_coin") and npc and npc.resource and npc.resource.currency_map:
				var currency_value = npc.resource.currency_map.currency_to_int_map.get(body.identifier, 0)
				weight += currency_value
			elif body.identifier == "artifact":
				weight += body.get_weight();
			else:
				weight += round_to_dec(body.mass, 3)
	
	if (playerSide):
		weight += trade_scene.flat_bonus
		weight = weight * trade_scene.multiplier_bonus
	
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
