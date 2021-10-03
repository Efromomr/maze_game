extends Area2D


var near = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(_event):
	if Input.is_action_pressed("pick_up") and near: 
		Utils.player.get_node("Dagger").count += 1
		queue_free()

func _on_Area2D_area_entered(_area):
	near = true


func _on_Area2D_area_exited(_area):
	near = false
