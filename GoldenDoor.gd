extends Area2D

var tile
var h_door = false
var near = false
var opened = false
var coords_x = -1
var coords_y = -1
var just_entered = false
var force_open
	
func _input(_event):
	if Input.is_action_pressed("pick_up") and near and Inventory.active_consumables.has('GoldenKey') and !opened: 
		get_parent().open_doors()
		opened = true
		
func _on_Node2D_body_exited(body):
	if h_door:
		if body.velocity[0] > 0:
			Utils.current_room_coords_x = coords_x
		else:
			Utils.current_room_coords_x = coords_x - 1
	else:
		if body.velocity[1] > 0:
			Utils.current_room_coords_y = coords_y
		else:
			Utils.current_room_coords_y = coords_y - 1
		
	if Utils.current_room_coords_x != Utils.old_room_coords_x or Utils.current_room_coords_y != Utils.old_room_coords_y:
		get_tree().get_root().get_node("Maze").get_fixed_rooms()
	near = false
		



func _on_Node2D_body_entered(_body):
	near = true
