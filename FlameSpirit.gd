extends KinematicBody2D

var dashing_timer
var state = IDLE
var collision_count = 0
var collision
var direction
onready var stats = $Node
var deathTimer
var blinkTimer

var damage = 1
enum {
	IDLE,
	WANDER,
	DASHING
}
var velocity = Vector2.ZERO
onready var animationState = $AnimationTree.get("parameters/playback")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().monster_count +=1
	add_to_group("Enemies")
	dashing_timer = Timer.new()
	dashing_timer.set_one_shot(true)
	dashing_timer.set_wait_time(5)
	dashing_timer.connect("timeout", self, "start_dashing")
	add_child(dashing_timer)
	
	deathTimer = Timer.new()
	deathTimer.set_one_shot(true)
	deathTimer.set_wait_time(0.2)
	deathTimer.connect("timeout", self, "queue_free")
	add_child(deathTimer)
	
	blinkTimer = Timer.new()
	blinkTimer.set_one_shot(true)
	blinkTimer.set_wait_time(0.1)
	blinkTimer.connect("timeout", self, "blink_ends")
	add_child(blinkTimer)

func start_dashing():
	state = DASHING
	animationState.travel("Dash")
	direction = global_position.direction_to(Utils.player.global_position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		IDLE:
			pass
		WANDER:
			collision = move_and_collide(velocity)
			animationState.travel("Idle")
			accelerate_towards_point(Utils.player.global_position, 50, delta)

		DASHING:
			rotation = direction.angle() - 1.3
			collision = move_and_collide(velocity)
			if collision and collision.collider is TileMap:
				collision_count +=1
				if collision_count == 4:
					state = WANDER
					collision_count = 0
					animationState.travel("Idle")
					rotation = 0
					dashing_timer.start()
				else:
					direction = global_position.direction_to(Utils.player.global_position)

			velocity = direction * delta * 500
					
					
func awake():
	state = WANDER
	dashing_timer.start()
func asleep():
	state = IDLE

func blink_ends():
	$Sprite.material.set("shader_param/active", false)
	$Sprite.modulate = Color(1, 1, 1, 1)
	
func accelerate_towards_point(point, speed, delta):
	var direction = global_position.direction_to(point)
	velocity = direction * delta * speed
	
	
func _on_Hurtbox_area_entered(area):
	if (stats.health - area.get_parent().damage >= 0):
		$Sprite.material.set("shader_param/active", true)
		blinkTimer.start()
	else:
		deathTimer.start()
	stats.health -= area.get_parent().damage
