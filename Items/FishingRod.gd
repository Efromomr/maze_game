extends Weapon

var portal_scene = preload("res://RodPortal.tscn")
var maze_cam
var maze
var loaded = false


# Called when the node enters the scene tree for the first time.
func _ready():
	maze = get_tree().get_root().get_node("Maze")
	maze_cam = maze.get_node('Camera2D')

func _init():
	texture = "FishingRod"
	own_offset_x = 3
	own_offset_y = 0

func _input(_event):
	if Input.is_action_just_released("attack"):
		if !loaded:
			Utils.map_active = true
			get_tree().get_root().get_node("Maze/CanvasLayer/Control/MiniMap").draw_maze()
			get_tree().get_root().get_node("Maze/CanvasLayer/Control/MiniMap").calling_node = self
			loaded = true
		
		
func room_chosen(x, y):
	var instance = portal_scene.instance()
	maze_cam.current = true
	maze_cam.offset.x = 80 + 300 * x
	maze_cam.offset.y = 120 + 200 * y
	instance.position.x = 80 + 300 * x
	instance.position.y = 120 + 200 * y
	maze.grid[x][y].get_node("Light2D").visible = true
	get_tree().get_root().add_child(instance)
	
	get_tree().get_root().get_node("Maze/CanvasLayer/Control/RichTextLabel").timer.start()
		
func attack():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FishingRod_tree_exiting():
	Utils.map_active = false
	get_tree().get_root().get_node("Maze/CanvasLayer/Control/MiniMap").draw_maze()
	
