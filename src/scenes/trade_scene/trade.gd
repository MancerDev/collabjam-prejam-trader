extends Node2D

var held_object = false

var npcs: Array[NPC] = [
	preload("res://assets/npc/blacksmith/blacksmith.tres"),
	preload("res://assets/npc/noble/noble.tres"),
	preload("res://assets/npc/troll/troll.tres"),
	preload("res://assets/npc/pirate/pirate.tres"),
	#preload("res://assets/npc/villager/villager.tres"),
]

var item_map: Dictionary = {
	"silver_coin": preload("res://src/scenes/trade_scene/pickable/coin/coin.tscn"),
	"food_coin": preload("res://src/scenes/trade_scene/pickable/FoodToken/food_coin.tscn")

}

var npc_scene = preload("res://src/scenes/npc_scene/npc.tscn")

func _ready():
	_spawn_npc()
	for node in get_tree().get_nodes_in_group("pickable"):
		node.clicked.connect(_on_pickable_object_clicked)
	for node in get_tree().get_nodes_in_group("spawner"):
		node.clicked.connect(_on_spawner_object_grab)
	for node in get_tree().get_nodes_in_group("spawnerButton"):
		node.clicked.connect(_on_spawner_object_click)
		

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
	var separator = %SideSeperator
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

func _despawn_npc():
	var npc = %Uninterractables.get_node_or_null("Npc")
	if npc:
		npc.set_sprite_state("happy")
		await get_tree().create_timer(1.0).timeout
		npc.set_sprite_state("back")
		
		# Despawn all items first
		for item in %Physics/NpcItems.get_children():
			_tween_node_out(item, 0.3)
		
		# Then despawn the NPC
		await _tween_node_out(npc, 1)
		return

func _spawn_npc():
	# Remove any existing NPC first
	var existing_npc = %Uninterractables.get_node_or_null("Npc")
	if existing_npc:
		existing_npc.queue_free()
	
	var npc_resource = npcs[randi() % npcs.size()]
	var npc = npc_scene.instantiate()
	npc.resource = npc_resource
	%Uninterractables.add_child(npc)
	npc.name = "Npc"
	npc.z_index = 5
	npc.position = %NPCPosition.position
	
	await _tween_node_in(npc)
	for item in npc_resource.inventory:
		var amount = npc_resource.inventory[item]
		for i in range(amount):
			var new_item = item_map[item].instantiate()
			%Physics/NpcItems.add_child(new_item)
			new_item.position = _get_spawn_position(true)
			new_item.identifier = item
			new_item.clicked.connect(_on_pickable_object_clicked)
			_tween_node_in(new_item, 0.3)
	return

func _on_button_pressed() -> void:
	await  _despawn_npc()
	await  _spawn_npc()
