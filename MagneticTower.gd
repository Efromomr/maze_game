extends Node2D


var target = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target != null:
		var direction = global_position.direction_to(target.global_position)
		direction *= Vector2(-1,-1)
		target.linear_velocity += direction * 500 * delta


func _on_Area2D_area_shape_entered(area_id, area, area_shape, local_shape):
	target = area.get_parent()


func _on_Area2D_area_shape_exited(area_id, area, area_shape, local_shape):
	target = null
