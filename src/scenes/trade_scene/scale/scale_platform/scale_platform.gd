extends RigidBody2D

var weight = 0;
var nodes_on_scale = [];
var platform;
var close_counter = 0  # Counter to track frames near the target
var target_threshold = 0.1  # Distance threshold to consider close to the target
var max_close_frames = 10  # The number of frames to be close to the target before setting it
@export var playerSide : bool

func _physics_process(delta):
	weight = $Platform.weight
	platform = $Platform
	platform.playerSide = playerSide

func slow_platform_movement(target_point):
	var newPos = (target_point - position).normalized()
	position += 0.1 * newPos
	
	# Check if the position is within the threshold of the target
	if abs(position.x - target_point.x) <= target_threshold and abs(position.y - target_point.y) <= target_threshold:
		close_counter += 1
	else:
		close_counter = 0  # Reset the counter if we're no longer close

	# If the platform has been close to the target for enough frames, set it directly to the target
	if close_counter >= max_close_frames:
		position = target_point
		close_counter = 0  # Reset the counter after setting the position
	
