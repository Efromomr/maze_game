extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _physics_process(_delta):
	var direction = (Utils.player.position - position).normalized()
	linear_velocity = direction * 200
	rotation = direction.angle() + 1


func _on_Area2D_body_entered(_body):
	queue_free()




func _on_Node2D_tree_exited():
	Utils.player.get_node("Dagger").count += 1
