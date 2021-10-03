extends Node

var buff = preload("res://IcyStormBuff.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var count = 1

# Called when the node enters the scene tree for the first time.
func consume():
	var instance = buff.instance()
	get_parent().get_parent().add_child(instance)
	Inventory.delete_consumable()
	queue_free()



func _input(_event):
	if Input.is_action_just_pressed("consumables_use"):
		consume()
