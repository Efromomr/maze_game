extends Weapon

var collides = false
var projectile = preload("res://Projectiles/IceSwordPro.tscn")
var instance


func initialize():
	instance = projectile.instance()
	instance.position = get_global_mouse_position() + Vector2(0,-10)
	get_tree().get_root().add_child(instance)
	var hand_scene = load("res://Hand1.tscn")
	var instance_h = hand_scene.instance()
	add_child(instance_h)

func attack():
	pass

func _on_IceSword_tree_exiting():
	instance.queue_free()
	
