extends Weapon


# Declare member variables here. Examples:
var shoot_speed = 2000
var projectile = load("res://Projectiles/DaggerPro.tscn")

	
func initialize():
	damage = 5
	count = 55
	texture = "Dagger"
	.initialize()
	
func shoot():
	self.count -=1 
	var proj_instance = projectile.instance()
	proj_instance.position.x = Utils.player.global_position.x + cos(get_local_mouse_position().angle()) * 20 
	proj_instance.position.y = Utils.player.global_position.y + sin(get_local_mouse_position().angle()) * 20 
	proj_instance.damage = damage
	var direction = (get_global_mouse_position() - Utils.player.global_position).normalized()
	proj_instance.rotation = direction.angle() - 0.3
	proj_instance.rotation_degrees += 45
	proj_instance.linear_velocity = direction * shoot_speed
	get_tree().get_root().add_child(proj_instance)
	
	#Inventory.delete_consumable()
	#queue_free()
	#cooldownTimer.start()
func _input(_event):
	if Input.is_action_just_pressed("attack") and count > 0:
		shoot()
		
func set_count(value):
	count = value
	Inventory.emit_signal("quantity_changed", count, "WeaponText")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
