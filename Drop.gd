extends Area2D
var item_id
var item_type
var quantity
var player_near = false


	
func _input(_event):
	if Input.is_action_pressed("pick_up") and player_near:
		match item_type:
			"Weapons/":
				if Input.is_action_pressed("pick_up"):
					Inventory.active_weapon = item_id
					queue_free()
			"Accessories/":
				if Input.is_action_pressed("pick_up"):
					Inventory.active_accessories.append(item_id)
					Inventory.emit_signal("accessory_changed")
					queue_free()
			"Consumables/":
				if Input.is_action_pressed("pick_up"):
					Inventory.active_consumables.append(item_id)
					queue_free()
	
	


	


func _on_Node_area_shape_entered(_area_id, _area, _area_shape, _local_shape):
	player_near = true


func _on_Node_area_shape_exited(_area_id, _area, _area_shape, _local_shape):
	player_near = false


