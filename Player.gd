extends KinematicBody2D


export var ACCELERATION = 2000
export var MAX_SPEED = 480
export var FRICTION = 2000

var old_pos
var velocity = Vector2.ZERO

var invincibilityTimer
var blinkTimer
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
var input_vector = Vector2.ZERO
var vec

var weapon
var direction 


#var rod = preload("res://Items/FishingRod.tscn")
var weapon_node = preload("res://WeaponNode.tscn")
func _ready():
	$Camera2D.custom_viewport = $"../.."
	weapon = get_node("Weapon")
	Utils.player = self
	instance_weapon("Down")
	var acc = load("res://Items/" + Inventory.current_consumable + ".tscn")
	var instance = acc.instance()
	Utils.player.add_child(instance)
	randomize()
	animationTree.active = true
	
	invincibilityTimer = Timer.new()
	invincibilityTimer.set_one_shot(true)
	invincibilityTimer.set_wait_time(2)
	invincibilityTimer.connect("timeout", self, "invincibility_ends")
	add_child(invincibilityTimer)
	
	blinkTimer = Timer.new()
	blinkTimer.set_one_shot(true)
	blinkTimer.set_wait_time(0.1)
	blinkTimer.connect("timeout", self, "blink_ends")
	add_child(blinkTimer)
	
	#var rod_instance = rod.instance()
	#add_child(rod_instance)

func _physics_process(delta):
	move_state(delta)
	
func move_state(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	vec = (get_global_mouse_position() - global_position).normalized()
	vec = Vector2(round(vec.x), round(vec.y))

	if input_vector != Vector2.ZERO:
		#animationTree.set("parameters/Idle/blend_position", (vec))
		animationTree.set("parameters/Run/blend_position", (vec))
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationTree.set("parameters/Idle/blend_position", (vec))
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()

func move():
	velocity = move_and_slide(velocity)
	
func blink_ends():
	$Sprite.material.set("shader_param/active", false)
	$Sprite.modulate = Color(1, 1, 1, 0.5)
	invincibilityTimer.start()
	
func invincibility_ends():
	$Area2D/Hurtbox.disabled = false
	$Sprite.modulate = Color(1, 1, 1, 1)


func _on_Area2D_body_entered(body):
	Inventory.health -= body.damage
	$Area2D/Hurtbox.set_deferred("disabled", true)
	$Sprite.material.set("shader_param/active", true)
	blinkTimer.start()

func instance_weapon(current_direction):
	if direction != current_direction and !Utils.isAttacking:
		direction = current_direction
		weapon.set_static_pos()
	direction = current_direction
	
func _input(event):
	if !Utils.isAttacking and Input.is_action_just_pressed("attack"):
		weapon.attack()
	


func _on_AnimationPlayer_tree_exiting():
	Utils.player.get_node("Sprite").texture = load("res://player_anim.png")
