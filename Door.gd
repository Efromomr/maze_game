extends Area2D

var tile
var tile_type
var just_entered = false
var force_open = false
var coords_y
var coords_x
var h_door = false

func _ready():
	tile_type = get_parent().get_cell(tile[0], tile[1])
	#add_to_group("doors")
	coords_x = int(((tile[0] - 13) / 30))
	coords_y = int(((tile[1] - 25) / 25))


func random_open():
	if (randi()% 3 == 0 and !force_open) or just_entered:
		close_door()
		just_entered = false
	else:
		open_door()
		force_open = false


func open_door():
	get_parent().set_cell(tile[0], tile[1], 3)

func close_door():
	get_parent().set_cell(tile[0], tile[1], 2)


func _on_Node2D_body_exited(body):
	if body.velocity[1] > 0:
		Utils.current_room_coords_y = coords_y + 1
	else:
		Utils.current_room_coords_y = coords_y
	if Utils.current_room_coords_y != Utils.old_room_coords_y:
		just_entered = true
		get_node("../..").get_fixed_rooms()
