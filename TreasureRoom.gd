extends Room

var golden_door = preload("res://GoldenDoor.tscn")
var ass = true


# Called when the node enters the scene tree for the first time.
func _init():
	treasure_room = true

func _ready():
	place_doors()
	
func place_doors():
	var instance = golden_door.instance()
	var instance2 = golden_door.instance()
	var instance3 = golden_door.instance()
	var instance4 = golden_door.instance()
	
	instance.position = Vector2(65, 20)
	instance2.position = Vector2(-86, 123)
	instance3.position = Vector2(213, 123)
	instance4.position = Vector2(65, 235)
	
	instance2.h_door = true
	instance3.h_door = true
	
	instance.coords_y = coords_y
	instance2.coords_x = coords_x
	instance3.coords_x = coords_x + 1
	instance4.coords_y = coords_y + 1
	
	add_child(instance)
	add_child(instance2)
	add_child(instance3)
	add_child(instance4)

func open_doors():
	$Foreground.set_cell(5, 3, -1)
	$Foreground.set_cell(-6, 13, 10)
	$Foreground.set_cell(17, 13, 10)
	$Foreground.set_cell(5, 22, -1)
