extends Node2D

var held_object = false

var npcs: Array[NPC] = [
	preload("res://assets/npc/blacksmith/blacksmith.tres"),
	preload("res://assets/npc/noble/noble.tres"),
	preload("res://assets/npc/troll/troll.tres"),
	preload("res://assets/npc/pirate/pirate.tres"),
	#preload("res://assets/npc/villager/villager.tres"),
]

var mysticalNpcs = [
	#headman
	preload("res://assets/npc/headman/headman.tres"),
	#fishman
	preload("res://assets/npc/fishman/mysticfish.tres"),
	#heron
	preload("res://assets/npc/heron/heron.tres"),
	#troll
	preload("res://assets/npc/troll/troll.tres"),
]

var noble = [
	#noble 
	preload("res://assets/npc/noble/noble.tres"),
	#noble B
	preload("res://assets/npc/noble_b/noble_b.tres"),
	#noble C
	preload("res://assets/npc/noble_c/noble_c.tres"),
]

var artisan  = [
	#pirate  
	preload("res://assets/npc/pirate/pirate.tres"),
	#blacksmith 
	preload("res://assets/npc/blacksmith/blacksmith.tres"),
	#hunter
	preload("res://assets/npc/hunter/hunter.tres"),
	#potter 
	preload("res://assets/npc/potter/potter.tres"),
]

var villager = [
	#villager 
	preload("res://assets/npc/villager/villager.tres"),
	#villager B 
	preload("res://assets/npc/villager_b/villager_b.tres"),
	#villager C 
	preload("res://assets/npc/villager_c/villager_c.tres"),
	#villager D 
	preload("res://assets/npc/villager_d/villager_d.tres"),
]

var failstateNpcs = [
	#headman
	#preload("res://assets/npc/headman/headman.tres"),
	#evilNoble
	preload("res://assets/npc/FailstateNPCs/Devilman1.tres"),
	preload("res://assets/npc/FailstateNPCs/Devilman2.tres"),
	preload("res://assets/npc/FailstateNPCs/Devilman3.tres"),
	preload("res://assets/npc/FailstateNPCs/Devilman4.tres"),
	preload("res://assets/npc/FailstateNPCs/Devilman5.tres"),
	preload("res://assets/npc/FailstateNPCs/Devilman6.tres"),
	preload("res://assets/npc/FailstateNPCs/Devilman7.tres"),
	preload("res://assets/npc/FailstateNPCs/Devilman8.tres"),
	preload("res://assets/npc/FailstateNPCs/Devilman9.tres"),
	preload("res://assets/npc/FailstateNPCs/Devilman10.tres"),
]

var allNPCS = [
	#headman
	preload("res://assets/npc/headman/headman.tres"),
	#fishman
	preload("res://assets/npc/fishman/mysticfish.tres"),
	#heron
	preload("res://assets/npc/heron/heron.tres"),
	#troll
	preload("res://assets/npc/troll/troll.tres"),
	
	#noble 
	preload("res://assets/npc/noble/noble.tres"),
	#noble B
	preload("res://assets/npc/noble_b/noble_b.tres"),
	#noble C
	preload("res://assets/npc/noble_c/noble_c.tres"),
	
	#pirate  
	preload("res://assets/npc/pirate/pirate.tres"),
	#blacksmith 
	preload("res://assets/npc/blacksmith/blacksmith.tres"),
	#hunter
	preload("res://assets/npc/hunter/hunter.tres"),
	#potter 
	preload("res://assets/npc/potter/potter.tres"),
	
	#villager 
	preload("res://assets/npc/villager/villager.tres"),
	#villager B 
	preload("res://assets/npc/villager_b/villager_b.tres"),
	#villager C 
	preload("res://assets/npc/villager_c/villager_c.tres"),
	#villager D 
	preload("res://assets/npc/villager_d/villager_d.tres"),
]

var item_map: Dictionary = {
	"silver_coin": preload("res://src/scenes/trade_scene/pickable/coin/coin.tscn"),
	"food_coin": preload("res://src/scenes/trade_scene/pickable/FoodToken/food_coin.tscn"),
	"magic_coin": preload("res://src/scenes/trade_scene/pickable/MagicToken/MagicToken.tscn"),
	"weapon_coin": preload("res://src/scenes/trade_scene/pickable/WeaponToken/WeaponToken.tscn"),
	
	"death_weight": preload("res://src/scenes/trade_scene/pickable/weight/weight.tscn"),
	
	"pearl" : preload("res://src/scenes/trade_scene/pickable/artifact/pearl/pearl.tscn"),
	"cushion" : preload("res://src/scenes/trade_scene/pickable/artifact/cushion/cushion_artifact.tscn"),
	"collisioner" : preload("res://src/scenes/trade_scene/pickable/artifact/collisioner/collisioner.tscn"),
	
	"magnet" : preload("res://src/scenes/trade_scene/pickable/artifact/magnet/Magnet.tscn"),
	"multiplier" : preload("res://src/scenes/trade_scene/pickable/artifact/multiplier/multiplier.tscn")
}

var npc_scene = preload("res://src/scenes/npc_scene/npc.tscn")


var current_day;
var todays_customers_left;
var todays_customers;

var flat_bonus = 0;
var multiplier_bonus = 1;


func _ready():
	$UI/banish_button.hide()
	$UI/deal_button.hide()
	$UI/give_up_button.hide()
	current_day = 1;
	todays_customers = 4;
	todays_customers_left = todays_customers;
	$UI/Control.TimeUpdate(22-round(14*todays_customers_left/todays_customers), todays_customers_left, current_day)
	
	
	#_spawn_npc()
	for node in get_tree().get_nodes_in_group("pickable"):
		node.clicked.connect(_on_pickable_object_clicked)
	for node in get_tree().get_nodes_in_group("spawner"):
		node.clicked.connect(_on_spawner_object_grab)
	for node in get_tree().get_nodes_in_group("spawnerButton"):
		node.clicked.connect(_on_spawner_object_click)
		

func _physics_process(delta: float) -> void: 
	if deal_check():
		$UI/deal_button.show()
	else:
		$UI/deal_button.hide()

signal held_object_dropped

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop()
			held_object = null
			held_object_dropped.emit();


func _on_pickable_object_clicked(object):
	if !held_object:
		object.pickup()
		held_object = object

func _on_spawner_object_grab(spawner, spawnable):
	var scene = spawnable.instantiate();
	var object = scene;
	add_child(object);
	object.clicked.connect(_on_pickable_object_clicked)
	_on_pickable_object_clicked(object)
	
	
func _on_spawner_object_click(spawner, spawnable, function = null):
	var scene = spawnable.instantiate();
	var object = scene;
	add_child(object);
	object.position = spawner.position;
	object.clicked.connect(_on_pickable_object_clicked)
	
	if function != null:
		function.call(spawner, object)
	#_on_pickable_object_clicked(object)

func _get_spawn_position(is_npc_side: bool) -> Vector2:
	# Probably needs update for more robust positioning that considers items size
	var separator = %CustomerItemsSeparator
	var viewport_size = get_viewport_rect().size
	var separator_width = 20  
	
	var left_zone_start = 0
	var left_zone_end = separator.position.x - separator_width/2
	var right_zone_start = separator.position.x + separator_width/2
	var right_zone_end = viewport_size.x
	
	var margin = 32
	var random_y = randf_range(margin, viewport_size.y - margin)
	
	var random_x
	if is_npc_side:
		random_x = randf_range(right_zone_start, right_zone_end)
	else:
		random_x = randf_range(left_zone_start, left_zone_end)
	
	return Vector2(random_x, random_y)

func _spawn_item(item, is_npc_side: bool = true):
	var scene = item_map[item].instantiate()
	%Physics/NpcItems.add_child(scene)
	scene.position = _get_spawn_position(is_npc_side)
	scene.clicked.connect(_on_pickable_object_clicked)
	if scene is coin:
		scene.identifier = item
	return scene

func _tween_node_out(node: Node2D, duration: float = 1) -> void:
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 0.0, duration)
	await tween.finished
	node.queue_free()
	await get_tree().process_frame  # Wait for the node to be actually freed
	return

func _tween_node_in(node: Node2D, duration: float = 1) -> void:
	node.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 1.0, duration)
	await tween.finished
	return

func _despawn_npc(leave_attitude = "happy"):
	var npc = %Uninterractables.get_node_or_null("Npc")
	if npc:
		npc.set_sprite_state(leave_attitude)
		await get_tree().create_timer(1.0).timeout
		npc.set_sprite_state("back")
		
		# Despawn all items first
		
		#for item in %Physics/NpcItems.get_children():
		#	_tween_node_out(item, 0.3)
		for item in get_tree().get_nodes_in_group("customer_items"):
			_tween_node_out(item, 0.3)
		# Then despawn the NPC
		await _tween_node_out(npc, 1)
		return

func _spawn_npc(npclist = [], rememberIndex = false, artifact_chance = 35):
	# Remove any existing NPC first
	var existing_npc = %Uninterractables.get_node_or_null("Npc")
	if existing_npc:
		existing_npc.queue_free()
		
	var index = floor(randf() * npclist.size())
	if rememberIndex:
		lastNpcs.push_back(index)
	
	var npc_resource = npclist[index]
	var npc = npc_scene.instantiate()
	npc.resource = npc_resource
	%Uninterractables.add_child(npc)
	npc.name = "Npc"
	npc.z_index = 5
	npc.position = %NPCPosition.position
	SfxSingleton.play_sound("entry_walk")
	await _tween_node_in(npc)
	for item in npc_resource.inventory:
		var amount = npc_resource.inventory[item]
		for i in range(amount):
			var new_item = item_map[item].instantiate()
			%Physics/NpcItems.add_child(new_item)
			new_item.set_collision_mask_value(5, false)
			new_item.set_collision_layer_value(5, false)
			new_item.position = _get_spawn_position(true)
			new_item.set_collision_mask_value(4, true)
			new_item.set_collision_layer_value(4, true)
			new_item.add_to_group("customer_items")
			new_item.identifier = item
			new_item.clicked.connect(_on_pickable_object_clicked)
			if (new_item.get_script() == weight):
				new_item.WeightSetUp(6, 1)
			_tween_node_in(new_item, 0.3)
			
	
	if (randf()*100 < artifact_chance):
		var artifacts = ["collisioner", "magnet", "multiplier", "cushion", "pearl"]
		var a_index = floor(randf() * artifacts.size())
		var item = _spawn_item(artifacts[a_index], true)
		item.set_collision_mask_value(5, false)
		item.set_collision_layer_value(5, false)
		item.set_collision_mask_value(4, true)
		item.set_collision_layer_value(4, true)
		item.add_to_group("customer_items")
	
	return


func deal_check():
	#return true;
	if !%Scale.SelfPlatform.platform:
		return false;
		
	if %Scale.SelfPlatform.platform.weight != 0 && %Scale.OtherPlatform.platform.weight != 0:
		if %Scale.SelfPlatform.platform.weight >= %Scale.OtherPlatform.platform.weight:
			return true;
		else: 
			return false;
	else:
		return false;



func deal_execute():
	for node in %Scale.SelfPlatform.platform.currentCollidedBodies:
		print(node)
		_tween_node_out(node, 0.3)
		
	var bodies = %Scale.OtherPlatform.platform.currentCollidedBodies.duplicate()
	for node in bodies:
		#if (node.has_method("OnBuy")):
		#	node.OnBuy()
		#node.set_collision_mask_value(4, false);
		#node.set_collision_layer_value(4, false);
		var new_item = node
		#%Physics/NpcItems.add_child(new_item)
		new_item.remove_from_group("customer_items") 
		new_item.set_collision_mask_value(4, false)
		new_item.set_collision_layer_value(4, false)
		node.apply_central_impulse(Vector2(-300, -330))
		new_item.set_collision_mask_value(9, false)
		new_item.set_collision_layer_value(9, false)
		new_item.set_collision_mask_value(10, false)
		new_item.set_collision_layer_value(10, false)
		
		
		#node.set_collision_mask_value(6, true);
		#node.set_collision_layer_value(6, true);
		#new_item.freeze = true
		#new_item.position = Vector2(100, 50)
		#new_item.freeze = false
		#new_item.identifier = item
		#new_item.clicked.connect(_on_pickable_object_clicked)
		#_tween_node_in(new_item, 0.3)
		
		#node.set_position(_get_spawn_position(true))
		#node.queue_free()
		
	await get_tree().create_timer(0.9).timeout
	for node in bodies:
		if (node.get_script() == food_token):
			$food_token_pile.update_quantity($food_token_pile.quantity+1);
			_tween_node_out(node, 0.4)
		elif (node.get_script() == coin):
			$CoinPile.update_quantity($CoinPile.quantity+1);
			_tween_node_out(node, 0.4)
		elif (node.get_script() == magic_token):
			$magic_token_pile.update_quantity($magic_token_pile.quantity+1);
			_tween_node_out(node, 0.4)
		elif (node.get_script() == weapon_token):
			$weapon_token_pile.update_quantity($weapon_token_pile.quantity+1);
			_tween_node_out(node, 0.4)
		elif (node.identifier == "artifact"):
			#_tween_node_out(node, 0.3)
			node.on_buy()
		#node.set_collision_mask_value(5, true);
		#node.set_collision_layer_value(5, true);$CoinPile 
		
		#node.set_collision_mask_value(6, false);
		#node.set_collision_layer_value(6, false);
		#new_item.set_collision_mask_value(5, true);
		#new_item.set_collision_layer_value(5, true);



func _on_deal_button_pressed() -> void:
	if deal_check():
		$UI/banish_button.hide()
		$UI/deal_button.hide()
		await deal_execute()
		await  _despawn_npc()
		$UI/next_customer_button.show()
		
		var deathWeightRemoved = false;
		for item in get_tree().get_nodes_in_group("death_weight"):
			deathWeightRemoved = true
			_tween_node_out(item, 0.4)
		
		if (deathWeightRemoved): 
			day_finish()


func _on_next_customer_button_pressed() -> void:
	$UI/next_customer_button.hide()
	await next_customer()
	


func _on_banish_button_pressed() -> void:
	$UI/banish_button.hide()
	$UI/deal_button.hide()
	await _despawn_npc("sad")
	$UI/next_customer_button.show()

var lastNpcs = [];
var len = 5;

func next_customer():
	if (todays_customers_left > 0): 
		todays_customers_left = todays_customers_left - 1;
		$UI/Control.TimeUpdate(22-round(14*todays_customers_left/todays_customers), todays_customers_left, current_day)
		var NPCArray = allNPCS.duplicate()
		#NPCArray.pop_at();
		if (len < lastNpcs.size()):
			var cur = lastNpcs[0]
			for i in range(lastNpcs.size()):
				var npcIndex = lastNpcs[i]
				if npcIndex >= cur:
					lastNpcs[i] += 1; 
			lastNpcs.pop_front()
		
		for num in lastNpcs:
			print(lastNpcs)
			NPCArray.pop_at(num)
		await _spawn_npc(NPCArray, true)
		$UI/banish_button.show()
		$UI/deal_button.show()
	else: 
		failstate_customer()


func failstate_customer():
	if (current_day < 10):
		await _spawn_npc([failstateNpcs[current_day-1]], false, 0)
	else:
		await _spawn_npc([failstateNpcs[9]], false, 0)
	
	$UI/banish_button.hide()
	$UI/deal_button.show()
	$UI/give_up_button.show()
	

func day_finish():
	
	#await _spawn_npc(failstateNpcs)
	current_day += 1;
	todays_customers += 1;
	todays_customers_left = todays_customers;
	$UI/Control.TimeUpdate(22-round(14*todays_customers_left/todays_customers), todays_customers_left, current_day)
	$UI/next_customer_button.show()
	$UI/banish_button.hide()
	$UI/deal_button.hide()
	$UI/give_up_button.hide()
	

func _on_give_up_button_pressed() -> void:
	get_node("/root/SceneChangeSingleton").openStartMenuScene()
	pass # Replace with function body.
