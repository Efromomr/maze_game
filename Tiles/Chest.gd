extends Area2D


var near = false
var opened = false
var item_type
var tile

func _on_Area2D_area_entered(_area):
	near = true

func _input(_event):
	if Input.is_action_pressed("pick_up") and near and !opened: 
		Utils.drop_item("Boots", global_position, "Accessories/")
		opened = true
func _on_Area2D_area_exited(_area):
	near = false
