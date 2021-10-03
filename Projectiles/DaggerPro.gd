extends RigidBody2D

var damage = 5
var stuck = preload("res://DaggerStuck.tscn")
var flying = preload("res://FlyingDagger.tscn")
var instance


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pas

func _on_Area2D_area_entered(area):
	if area.collision_layer!=1:
		instance = flying.instance()
		#get_tree().get_root().call_deferred("add_child", instance)
		instance.position = position
		queue_free()
	else:
		linear_velocity = Vector2.ZERO
		instance = stuck.instance()
		#get_tree().get_root().call_deferred("add_child", instance)
		instance.position = position
		instance.rotation = rotation
		queue_free()





func _on_RigidBody2D_tree_exited():
	get_tree().get_root().call_deferred("add_child", instance)


func _on_RigidBody2D_tree_exiting():
	get_tree().get_root().call_deferred("add_child", instance)


func _on_RigidBody2D_body_entered(body):
		linear_velocity = Vector2.ZERO
		instance = stuck.instance()
		instance.position = position
		instance.rotation = rotation
		#get_tree().get_root().call_deferred("add_child", instance)
		
		queue_free()
