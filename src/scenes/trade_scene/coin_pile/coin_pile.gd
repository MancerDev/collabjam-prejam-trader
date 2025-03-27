extends RigidBody2D

class_name coin_pile

var coin_scene = load("res://src/scenes/trade_scene/pickable/coin/coin.tscn")
var coin_image_thresholds : Dictionary 

@onready var trade_node: Node2D = get_node("/root/SceneChangeSingleton/Scenes/Trade")

signal clicked
@export var quantity : int
var savedBody
var storedObjectScript = coin

func _ready() -> void:
	coin_image_thresholds = {
	1: %Size1,
	3: %Size2,
	5: %Size3,
	10: %Size4
	}
	
	update_image()
	%Label.text = str(quantity)
	print("fdsfddfsd")
	trade_node.held_object_dropped.connect(_on_held_object_dropped);

func update_quantity(_quantity: int):
	quantity = _quantity
	update_image()
	%Label.text = str(quantity)

func update_image():
	var selected_image #: Texture = null
	
	# Find the relevant image based on thresholds
	for sprite in coin_image_thresholds.values():
		sprite.hide()
	
	for threshold in coin_image_thresholds.keys():
		if quantity >= threshold:
			selected_image = coin_image_thresholds[threshold]
		else:
			break
	
	# If quantity is 0, hide the image
	if selected_image == null or quantity == 0:
		true;
		#selected_image.hide()
	else:
		#%Sprite.texture = selected_image
		selected_image.show()

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed && quantity > 0:
			clicked.emit(self, coin_scene)
			update_quantity(quantity - 1)


func _on_mouse_entered() -> void:
	pass
	


func _on_body_entered(body: Node) -> void:
	savedBody = null;
	if (body.get_script() == storedObjectScript):
		if (!trade_node.held_object):
			body.queue_free()
			update_quantity(quantity + 1)
		else:
			savedBody = body
	
	pass # Replace with function body.
	
func _on_body_exited(body: Node) -> void:
	if (savedBody):
		if (body.name == savedBody.name):
			savedBody = null
	pass # Replace with function body.


func _on_held_object_dropped() -> void:
	if (savedBody && !trade_node.held_object):
		savedBody.queue_free();
		update_quantity(quantity + 1)

	pass # Replace with function body.
