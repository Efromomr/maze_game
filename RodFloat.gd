extends Node2D


var damage = 15


func _physics_process(_delta):
	position = get_global_mouse_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
