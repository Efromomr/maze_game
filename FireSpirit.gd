extends KinematicBody2D

var player
var state
var deathTimer
var damage = 1
onready var stats = $Node
var velocity = Vector2.ZERO
var collision = Vector2.ZERO
var blinkTimer

enum {
	IDLE,
	WANDER,
	HURT,
	DEAD
}

func _ready():
	get_parent().monster_count +=1
	add_to_group("Enemies")
	player = Utils.player
	state = IDLE
	deathTimer = Timer.new()
	deathTimer.set_one_shot(true)
	deathTimer.set_wait_time(0.2)
	deathTimer.connect("timeout", self, "queue_free")
	add_child(deathTimer)
	accelerate_towards_point(player.global_position)
	
	blinkTimer = Timer.new()
	blinkTimer.set_one_shot(true)
	blinkTimer.set_wait_time(0.1)
	blinkTimer.connect("timeout", self, "blink_ends")
	add_child(blinkTimer)
	


func _process(_delta):
	if state == IDLE:
		pass
	else:
		collision = move_and_collide(velocity)
		if collision and collision.collider is TileMap:
				accelerate_towards_point(player.global_position)

func accelerate_towards_point(point):
	var direction = global_position.direction_to(point)
	velocity = direction * 2
	$Sprite.flip_h = velocity.x < 0
	
func _on_Hurtbox_area_entered(area):
	if (stats.health - area.get_parent().damage >= 0):
		state = HURT
		$Sprite.material.set("shader_param/active", true)
		blinkTimer.start()
	else:
		deathTimer.start()
		state = DEAD
	stats.health -= area.get_parent().damage
	#knockback = area.get_parent().knockback_vector * 150
	
func blink_ends():
	$Sprite.material.set("shader_param/active", false)
	$Sprite.modulate = Color(1, 1, 1, 1)

func awake():
	state = WANDER
func asleep():
	state = IDLE







func _on_KinematicBody2D_tree_exiting():
	get_parent().monster_count -= 1
