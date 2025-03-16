extends Node2D
var held_object = false

func _ready():
	for node in get_tree().get_nodes_in_group("pickable"):
		node.clicked.connect(_on_pickable_object_clicked)
		

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
