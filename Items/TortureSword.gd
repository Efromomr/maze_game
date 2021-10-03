extends Weapon


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	texture = "TortureSword"
	melee = true
	damage = 5
	
func attack():
	$Area2D/CollisionShape2D.disabled = false
	.attack()
	
func _attack_complete():
	$Area2D/CollisionShape2D.disabled = true
	._attack_complete()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
