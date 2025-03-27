extends RigidBody2D

@export var sway_amplitude: float = 0.1  # How far the cage sways
@export var sway_speed: float = 1.0      # How fast the cage sways
var time: float = 0.0

func _physics_process(delta):
	time += delta
	# Use sine wave to create smooth swaying motion
	var sway = sin(time * sway_speed) * sway_amplitude
	# Apply rotation to the cage
	rotation = sway 
