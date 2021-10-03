extends Node2D

var bomb = preload("res://Projectiles/FlyingBomb.tscn")
var cooldown_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	cooldown_timer = Timer.new()
	cooldown_timer.set_one_shot(true)
	cooldown_timer.set_wait_time(5)
	cooldown_timer.connect("timeout", self, "launch_bomb")
	add_child(cooldown_timer)
	cooldown_timer.start()

func launch_bomb():
	var instance = bomb.instance()
	instance.position = position
	add_child(instance)
	cooldown_timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
