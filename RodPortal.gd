extends Node2D

var float_scene = preload("res://FloatRod.tscn")
var instance


# Called when the node enters the scene tree for the first time.
func _ready():
	instance = float_scene.instance()
	get_tree().get_root().add_child(instance)
	
func _physics_process(_delta):
	$Line2D.set_point_position(1, to_local(instance.position))
	instance.rotation = to_local(instance.position).angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
