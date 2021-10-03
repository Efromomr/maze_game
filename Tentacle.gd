extends RigidBody2D


var timer

func _ready():
	timer = Timer.new()
	timer.set_wait_time(0.1)
	timer.connect("timeout", self, "spawn_segment")
	add_child(timer)
	
func spawn_segment():
	var segment = StaticBody2D.new()
	
