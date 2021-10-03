extends Node


var movesCounter = 10

func _ready():
	var maze = get_parent()
	get_tree().call_group("rooms", "freeze")
	Utils.player.FRICTION -= 400
	maze.connect("step", self, "step_made")
	
func step_made():
	movesCounter-=1
	if movesCounter == 0:
		queue_free()
func _exit_tree():
	Utils.player.FRICTION += 400
	get_tree().call_group("rooms", "unfreeze")
