extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var deathTimer
var blinkTimer

var tile
onready var stats = $Stats
# Called when the node enters the scene tree for the first time.
func _ready():
	deathTimer = Timer.new()
	deathTimer.set_one_shot(true)
	deathTimer.set_wait_time(0.2)
	deathTimer.connect("timeout", self, "queue_free")
	add_child(deathTimer)
	
	blinkTimer = Timer.new()
	blinkTimer.set_one_shot(true)
	blinkTimer.set_wait_time(0.1)
	#blinkTimer.connect("timeout", self, "blink_ends")
	add_child(blinkTimer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if (stats.health - area.get_parent().damage > 0):
		#state = HURT
		blinkTimer.start()
	else:
		deathTimer.start()
		#state = DEAD
	stats.health -= area.get_parent().damage


func _on_Node2D_tree_exiting():
	var tile_pos = get_parent().world_to_map(position)
	if get_parent().get_cellv(tile_pos) == 1 and get_parent().get_cellv(tile_pos + Vector2(0,-1)) != -1:
		get_parent().set_cellv(tile_pos + Vector2(0,-1), 1)
	get_parent().set_cellv(tile_pos, -1)
	get_parent().update_bitmask_region()
	
