extends Area2D

var tile
var tile_type
var just_entered = false
var coords_x
var coords_y
var force_open = false
var h_door = true

func _ready():
	tile_type = get_parent().get_cell(tile[0], tile[1])
	add_to_group("doors")
	coords_x = int(((tile[0] - 30) / 30))
	coords_y = int(((tile[1] - 12) / 25))

func random_open():
	if (randi()% 3 == 0 and !force_open) or just_entered:
		close_door()
		just_entered = false
	else:
		open_door()
		force_open = false
func open_door():
	get_parent().set_cell(tile[0], tile[1], 1)
	get_parent().set_cell(tile[0], tile[1]+1, 4)

func close_door():
	get_parent().set_cell(tile[0], tile[1], 0)
	get_parent().set_cell(tile[0], tile[1]+1, -1)





func _on_Node2D_body_exited(body):
	if body.velocity[0] > 0:
		Utils.current_room_coords_x = coords_x + 1
	else:
		Utils.current_room_coords_x = coords_x 
	if Utils.current_room_coords_x != Utils.old_room_coords_x:
		just_entered = true
		get_node("../..").get_fixed_rooms()
