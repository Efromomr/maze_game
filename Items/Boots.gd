extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().ACCELERATION +=100
	get_parent().MAX_SPEED += 50 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
