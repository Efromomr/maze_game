extends Node2D


# Declare member variables here. Examples:
# var a = 2
var damage
var shoot_speed = 100
var projectile = load("res://Projectiles/BombPro.tscn")
var count = 1

# Called when the node enters the scene tree for the first time.
func shoot():
	var proj_instance = projectile.instance()
	proj_instance.position.x = Utils.player.position.x + cos(get_local_mouse_position().angle()) * 20 
	proj_instance.position.y = Utils.player.position.y + sin(get_local_mouse_position().angle()) * 20 
	proj_instance.rotation = get_local_mouse_position().angle() + 1.5
	proj_instance.damage = damage
	var direction = (get_global_mouse_position() - Utils.player.position).normalized()
	proj_instance.linear_velocity = direction * shoot_speed
	get_tree().get_root().add_child(proj_instance)
	Inventory.delete_consumable()
	queue_free()
	#cooldownTimer.start()
func _input(_event):
	if Input.is_action_just_pressed("consumables_use"):
		shoot()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
