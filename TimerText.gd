extends RichTextLabel


var timer


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(15)
	add_child(timer)
	timer.connect("timeout", self, "fishing_ends")
	
func _process(_delta):
	if timer.time_left > 0:
		var minute = 0
		var second = timer.time_left
		text = "%02d:%02d" % [minute, second]
	else:
		pass
	
func fishing_ends():
	Utils.player.get_node("Camera2D").current = true
	get_tree().get_root().get_node("RodPortal").queue_free()
	get_tree().get_root().get_node("Float").queue_free()
	get_parent().get_node("MiniMap").calling_node.loaded = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
