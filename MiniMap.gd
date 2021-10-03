extends Node


var maze
var maze_cam
var button_group
var calling_node
var portal_scene = preload("res://RodPortal.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	maze = get_tree().get_root().get_node("Maze")
	maze_cam = maze.get_node("Camera2D")
	button_group = ButtonGroup.new()
	maze.connect('step', self, 'draw_maze')
	
func draw_maze():
	var children = get_children()
	for c in children:
		remove_child(c)
		c.queue_free()
	for i in range(8):
		for j in range(8):

			var room_sprite
			room_sprite = TextureButton.new()
			room_sprite.set_button_group(button_group)
			room_sprite.disabled = true
			if Utils.current_room_coords_x == j and Utils.current_room_coords_y == i:
				if Utils.map_active:
					room_sprite.texture_normal = load("res://room_cur_b.png")
				else:
					room_sprite.texture_normal = load("res://room_cur.png")
			elif maze.grid[j][i].treasure_room and Inventory.active_accessories.has("Map"):
				if Utils.map_active:
					room_sprite.texture_normal = load("res://room_tre_b.png")
				else:
					room_sprite.texture_normal = load("res://room_tre.png")
			elif maze.grid[j][i].has_monsters and Inventory.active_accessories.has("Map"):
				if Utils.map_active:
					room_sprite.texture_normal = load("res://room_ene_b.png")
				else:
					room_sprite.texture_normal = load("res://room_ene.png")
			elif !maze.grid[j][i].has_monsters and Inventory.active_accessories.has("Map"):
				if Utils.map_active:
					room_sprite.texture_normal = load("res://room_safe_b.png")
				else:
					room_sprite.texture_normal = load("res://room_safe.png")	
			else:
				if Utils.map_active:
					room_sprite.texture_normal = load("res://room_def_b.png")
				else:
					room_sprite.texture_normal = load("res://room_def.png")
			room_sprite.connect("pressed", self, "room_chosen")
			add_child(room_sprite)
			if Utils.map_active:
				var arr = button_group.get_buttons()
				for a in arr:
					a.disabled = false
			var arr = button_group.get_buttons()
			#maze.new_grid[i][j]
	
func activate_buttons():
	var arr = button_group.get_buttons()
	for i in arr:
		i.disabled = false
		i.texture_normal = load(i.get_normal_texture().resource_path.replace(".png", "_b.png"))
		
func room_chosen():
	Utils.map_active = false
	var i = button_group.get_pressed_button().margin_left / 10
	var j = button_group.get_pressed_button().margin_top / 10
	calling_node.room_chosen(i, j)

	draw_maze()
	
