extends Area2D

var destination_x
var destination_y

func _on_Area2D_area_entered(_area):
	Utils.current_room_coords_x = destination_x
	Utils.current_room_coords_y = destination_y
	var maze = get_parent().get_parent()
	Utils.player.position = maze.grid[destination_x][destination_y].get_node("Portal").position
