extends RigidBody2D

var destination
var has_reached = false
var direction
var medium_velocity

#func _ready():
	#destination = Utils.player.position
	#medium_velocity = position.distance_to(destination) / 5
	#direction = (position - Utils.player.position).normalized()
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if scale > Vector2(0.1, 0.1):
		scale -= Vector2(0.5 * delta, 0.5 * delta)
		#linear_velocity = Vector2(1 * delta, 1 * delta) * direction
	#else:
		#linear_velocity += Vector2(1 * delta, 1 * delta) * direction
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
