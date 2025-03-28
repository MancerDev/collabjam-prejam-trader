extends DragabbleObject

class_name artifact


@export var description : String



func _ready():
	%PanelContainer.hide()
	%Label.text = description;

#func _physics_process(delta: float) -> void:
	#lock_rotation = true;

func on_buy():
	pass

func _on_child_exiting_tree(node: Node) -> void:
	pass # Replace with function body.

func get_weight():
	return 1;

func _mouse_enter() -> void:
	%PanelContainer.show()
	

func _mouse_exit() -> void:
	%PanelContainer.hide()
