extends Projectile


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var deathTimer = Timer.new()
	deathTimer.set_one_shot(true)
	deathTimer.set_wait_time(5)
	deathTimer.connect("timeout", self, "queue_free")
	add_child(deathTimer)
	deathTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
