extends Node2D

var room = preload("res://Room.tscn")
var treasure_room = preload("res://TreasureRoom.tscn")
var grid = []
var new_grid = []
var initial_grid = []
var fixed_rooms = [Vector2(0,0), Vector2(1,2), Vector2(3,3), Vector2(3,4), Vector2(4,3), Vector2(4,4)]
var current_fixed_rooms = []
var current_room

signal step

# Called when the node enters the scene tree for the first time.
func _ready():
	place_tiles()
	for x in range(8):
		grid.append([])
		grid[x]=[]
		initial_grid.append([])
		initial_grid[x]=[]
		for y in range(8):
			var room_instance = room.instance()
			room_instance.position.x = x*240*4
			room_instance.position.y = y*150*4
			grid[x].append([])
			grid[x][y]=room_instance
			grid[x][y].coords_x = x
			grid[x][y].coords_y = y
			get_tree().get_root().call_deferred("add_child", room_instance)
			initial_grid[x].append([])
			initial_grid[x][y]=0
	var local_room = grid[0][0]
	local_room.get_node("Light2D").visible = true
	#Utils.spawn_enemy("Jelly", Vector2(298, 150))
	#grid[1][0].has_monsters = true
	grid[1][0].spawn_enemy("FlameSpirit", Vector2(25, 55))
#grid[1][0].spawn_enemy("FlyingSword", Vector2(198, 199))
	$CanvasLayer/Control/MiniMap.draw_maze()
#local_room.get_node("CanvasModulate").visible = false
	$TileMap3.place_tile_scenes()
	
func place_tiles():
	var room_height = 25
	var room_width = 30
	var total_height = room_height * 8
	var total_width = room_width * 8
	
	#up and down walls
	for i in range(1, total_width):
		for y in range(1, 6):
			$TileMap.set_cell(i, total_height+y, 1)
			$TileMap.set_cell(i, y, 1)
	
	for i in range(1, total_width):
		$TileMap.set_cell(i, total_height, 2)
		$TileMap.set_cell(i, 0, 2)
		
	#generating left wall
	for x in range (1, total_width, room_width):
		for y in range(room_height, total_height, room_height):
			for i in range(room_width/2 - 3):
				for j in range(6):
					$TileMap.set_cell(x+i, y+j, 1)
	#generating right wall
	for x in range (room_width/2+1, total_width, room_width):
		for y in range(1, total_height, room_height):
			for i in range(room_width/2):
				for j in range(5):
					$TileMap.set_cell(x+i, y+j, 1)
	#generating roof
	for x in range (1, total_width, room_width):
		for y in range(0, total_height, room_height):
			for i in range(room_width/2 - 3):
				$TileMap.set_cell(x+i, y, 2)
	for x in range (room_width/2+1, total_width, room_width):
		for y in range(0, total_height, room_height):
			for i in range(room_width/2):
				$TileMap.set_cell(x+i, y, 2)
				
	#generating vertical walls
	for x in range (room_width, total_width, room_width):
		for y in range(1, total_height+1, 1):
			$TileMap.set_cell(x, y, 5)
			
	for x in range (room_width, total_width, room_width):
		for y in range(room_height/2, total_height, room_height):
			for j in range(4):
				$TileMap.set_cell(x, y+j, 6)
	
	for x in range (0, room_width*9, room_width):
		$TileMap.set_cell(x, 0, 3)
		
				
	#generating doors
	for x in range (room_width, total_width, room_width):
		for y in range(room_height/2, total_height, room_height):
			$TileMap3.set_cell(x, y, 1)
			$TileMap3.set_cell(x, y+1, 4)
	for x in range (room_width/2 - 2, total_width, room_width):
		for y in range(room_height, total_height, room_height):
			$TileMap3.set_cell(x, y, 3)
	
	#generating columns 
	for x in range (room_width/2 - 3, total_width, room_width):
		for y in range(1+room_height, total_height, room_height):
			for j in range(5):
				$TileMap.set_cell(x, y+j, 4)
				$TileMap.set_cell(x+4, y+j, 4)
	for x in range (room_width/2 - 3, total_width, room_width):
		for y in range(room_height, total_height, room_height):
				$TileMap.set_cell(x, y, 7)
				$TileMap.set_cell(x+4, y, 3)
	
	#right and left borders
	for j in range(1, total_height+1):
		$TileMap.set_cell(0, j, 5)
		$TileMap.set_cell(total_width, j, 5)
		
	#down columns
	for j in range(total_height+1, total_height+6):
		$TileMap.set_cell(0, j, 4)
		$TileMap.set_cell(total_width, j, 4)
	
			
	for x in range (room_width, total_width, room_width):
		for y in range (room_height, total_height, room_height):
			for j in range(5):
				$TileMap.set_cell(x, y+j+1, 4)
	for x in range (room_width, total_width, room_width):
		for y in range (room_height, total_height, room_height):
			$TileMap.set_cell(x, y+6, 6)
	$TileMap.update_bitmask_region()

func step():
	randomize()
	new_grid = initial_grid.duplicate(true)
	for k in range(current_fixed_rooms.size()):
		new_grid[int(current_fixed_rooms[k].x)][int(current_fixed_rooms[k].y)] = grid[int(current_fixed_rooms[k].x)][int(current_fixed_rooms[k].y)]
	var dir = Utils.random_choice([Vector2.DOWN, Vector2.UP, Vector2.RIGHT, Vector2.LEFT])
	match dir:
		Vector2.DOWN:
			for x in range(8):
				var y_array = []
				for y in range (8):
					if !(Vector2(x,y) in current_fixed_rooms):
						y_array.append(y)
				var y_array_sorted = y_array.duplicate()
				var new_elem = y_array_sorted.pop_back()
				y_array_sorted.push_front(new_elem)
				for y in (y_array.size()):
					new_grid[x][y_array[y]] = grid[x][y_array_sorted[y]]
		Vector2.UP:
			for x in range(8):
				var y_array = []
				for y in range (8):
					if !(Vector2(x,y) in current_fixed_rooms):
						y_array.append(y)
				var y_array_sorted = y_array.duplicate()
				var new_elem = y_array_sorted.pop_front()
				y_array_sorted.push_back(new_elem)
				for y in (y_array.size()):
					new_grid[x][y_array[y]] = grid[x][y_array_sorted[y]]
		Vector2.RIGHT:
			for y in range(8):
				var x_array = []
				for x in range (8):
					if !(Vector2(x,y) in current_fixed_rooms):
						x_array.append(x)
				var x_array_sorted = x_array.duplicate()
				var new_elem = x_array_sorted.pop_back()
				x_array_sorted.push_front(new_elem)
				for x in (x_array.size()):
					new_grid[x_array[x]][y] = grid[x_array_sorted[x]][y]
		Vector2.LEFT:
			for y in range(8):
				var x_array = []
				for x in range (8):
					if !(Vector2(x,y) in current_fixed_rooms):
						x_array.append(x)
				var x_array_sorted = x_array.duplicate()
				var new_elem = x_array_sorted.pop_front()
				x_array_sorted.push_back(new_elem)
				for x in (x_array.size()):
					new_grid[x_array[x]][y] = grid[x_array_sorted[x]][y]
	grid = new_grid.duplicate(true)
	emit_signal("step")
	place()

func place():
	for i in range (8):
		for j in range (8):
			current_room = grid[i][j]
			current_room.coords_x = i
			current_room.coords_y = j
			current_room.position.x = i * 240 * 4
			current_room.position.y = j * 150 * 4
	set_current_room()
			
func set_current_room():
	var old_room = grid[Utils.old_room_coords_x][Utils.old_room_coords_y]
	old_room.get_node("Light2D").visible = false
	old_room.room_exited()
	#old_room.get_node("CanvasModulate").visible = true
	Utils.old_room_coords_x = Utils.current_room_coords_x
	Utils.old_room_coords_y = Utils.current_room_coords_y
	var local_room = grid[Utils.current_room_coords_x][Utils.current_room_coords_y]
	local_room.get_node("Light2D").visible = true
	local_room.room_entered()
	#local_room.get_node("CanvasModulate").visible = false
	var doors_around = []
	var doors = get_tree().get_nodes_in_group("doors")
	for door in doors:
		if door.just_entered == false:
			if (Utils.current_room_coords_x == door.coords_x and Utils.current_room_coords_y == door.coords_y) or (Utils.current_room_coords_x == door.coords_x and Utils.current_room_coords_y-1 == door.coords_y and door.h_door == false) or (Utils.current_room_coords_x-1 == door.coords_x and Utils.current_room_coords_y == door.coords_y and door.h_door == true):
				doors_around.append(door)
	#local_room.call_deferred("add_child", Utils.player)
	Utils.random_choice(doors_around).force_open = true
	#get_tree().call_group("doors", "random_open")
	
	
	

		
func get_fixed_rooms():
	current_fixed_rooms = fixed_rooms.duplicate()
	current_fixed_rooms.append(Vector2(Utils.current_room_coords_x, Utils.current_room_coords_y))
	if Utils.current_room_coords_x!=0:
		current_fixed_rooms.append(Vector2(Utils.current_room_coords_x-1, Utils.current_room_coords_y))
	if Utils.current_room_coords_x!=7:
		current_fixed_rooms.append(Vector2(Utils.current_room_coords_x+1, Utils.current_room_coords_y))
	if Utils.current_room_coords_y!=0:
		current_fixed_rooms.append(Vector2(Utils.current_room_coords_x, Utils.current_room_coords_y-1))
	if Utils.current_room_coords_y!=7:
		current_fixed_rooms.append(Vector2(Utils.current_room_coords_x, Utils.current_room_coords_y+1))
	step() 

	
