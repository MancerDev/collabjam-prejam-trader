extends RigidBody2D

class_name coin_pile

var coin_scene = load("res://src/scenes/trade_scene/pickable/coin/coin.tscn")
var coin_image_thresholds : Dictionary = {
	1: load("res://assets/images/coin/coin15.png"),
	3: load("res://assets/images/coin/coin29.png"),
	5: load("res://assets/images/coin/coin43.png"),
	10: load("res://assets/images/coin/coin57.png")
}
signal clicked
@export var quantity : int

func _ready() -> void:
	update_image()
	%Label.text = str(quantity)
	get_node("/root/Trade").held_object_dropped.connect(_on_held_object_dropped);

func update_quantity(_quantity: int):
	quantity = _quantity
	update_image()
	%Label.text = str(quantity)

func update_image():
	var selected_image : Texture = null

	# Find the relevant image based on thresholds
	for threshold in coin_image_thresholds.keys():
		if quantity >= threshold:
			selected_image = coin_image_thresholds[threshold]
		else:
			break
	
	# If quantity is 0, hide the image
	if selected_image == null or quantity == 0:
		%Sprite.texture = null
	else:
		%Sprite.texture = selected_image

func _on_input_event(viewport, event, shape_idx):
	print("a")
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("clicked")
			clicked.emit(self, coin_scene)
			update_quantity(quantity - 1)


func _on_mouse_entered() -> void:
	print("asd") # Replace with function body.
	
	

var savedBody
var storedObjectScript = coin

func _on_body_entered(body: Node) -> void:
	print(body)
	savedBody = null;
	if (body.get_script() == storedObjectScript):
		if (!get_node("/root/Trade").held_object):
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
	if (savedBody && !get_node("/root/Trade").held_object):
		savedBody.queue_free();
		update_quantity(quantity + 1)

	pass # Replace with function body.
