extends RigidBody2D
class_name Projectile

var damage = 1
		

func _on_Hitbox_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	queue_free()


func _on_Node2D_body_shape_entered(_body_id, _body, _body_shape, _local_shape):
	queue_free()
