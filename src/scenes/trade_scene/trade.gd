extends Node2D
var held_object = false

func _ready():
	for node in get_tree().get_nodes_in_group("pickable"):
		node.clicked.connect(_on_pickable_object_clicked)
	for node in get_tree().get_nodes_in_group("spawner"):
		print("as")
		node.clicked.connect(_on_spawner_object_grab)
	for node in get_tree().get_nodes_in_group("spawnerButton"):
		print("as")
		node.clicked.connect(_on_spawner_object_click)
		

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if held_object and !event.pressed:
			print(held_object)
			held_object.drop()
			held_object = null


func _on_pickable_object_clicked(object):
	if !held_object:
		object.pickup()
		held_object = object

func _on_spawner_object_grab(spawner, spawnable):
	print("a")
	var scene = spawnable.instantiate();
	var object = scene;
	add_child(object);
	object.clicked.connect(_on_pickable_object_clicked)
	_on_pickable_object_clicked(object)
	
	
func _on_spawner_object_click(spawner, spawnable, function = null):
	print("a")
	var scene = spawnable.instantiate();
	var object = scene;
	add_child(object);
	object.position = spawner.position;
	object.clicked.connect(_on_pickable_object_clicked)
	
	if function != null:
		function.call(spawner, object)
	#_on_pickable_object_clicked(object)
	
