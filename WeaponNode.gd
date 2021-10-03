extends Node2D
class_name Weapon 

var offset_x = 0
var offset_y = 0
var own_offset_x = 0
var own_offset_y = 0
var direction
var cooldown_timer

var radius = 7
var faceRight = 1

var melee = false
var angle
var cooldown = 0.4
var texture = "TortureSword"
var count = null setget set_count
var damage = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	initialize()
	
func initialize():
	Inventory.connect("weapon_changed", self, "set_static_pos")
	cooldown_timer = Timer.new()
	cooldown_timer.set_one_shot(false)
	cooldown_timer.set_wait_time(cooldown)
	cooldown_timer.connect("timeout", self, "_attack_complete")
	$Sprite.texture = load("res://Items/" + texture + ".png")
	add_child(cooldown_timer)
	var hand_scene = load("res://Hand1.tscn")
	var instance = hand_scene.instance()
	add_child(instance)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		if Utils.isAttacking:
			if direction == "Down" or direction == "Left":
				faceRight = -1
			else:
				faceRight = 1
			$Sprite.flip_h = false
			$Sprite.flip_v = false
				
			position.x = cos(angle) * radius 
			position.y = sin(angle) * radius
			rotation = angle
			$Sprite.scale.y = faceRight
			if faceRight == -1:
				$Sprite2.position.x = faceRight * 4
				$Sprite2.position.y = faceRight * 6
			if melee:
				angle += delta * 30 * faceRight
func attack():
	angle = Utils.player.get_local_mouse_position().angle()
	Utils.isAttacking = true
	cooldown_timer.start()
				
func _attack_complete():
	Utils.isAttacking = false
	Utils.player.instance_weapon(Utils.player.direction)
	set_static_pos()
	
func set_static_pos():
	direction = Utils.player.direction
	if direction == "Down" or direction == "Left":
		faceRight = -1
	else:
		faceRight = 1
	$Sprite.scale.y = 1
	rotation = 0
	$Sprite.flip_h = false
	$Sprite.flip_v = false
	$Sprite2.position.y = 6
	match direction:
		"Down":
			$Sprite.flip_h = true
			$Sprite2.flip_h = true
			position.x = -10
			position.y = -3
			$Sprite2.position.x = 4
			set_draw_behind_parent(false)
		"Up":
			position.x = 10
			position.y = -5
			$Sprite2.position.x = -5
			set_draw_behind_parent(true)
		"Right":
			$Sprite2.flip_h = false
			position.y = -2
			position.x = 6
			$Sprite2.position.x = -5
			set_draw_behind_parent(false)
		"Left":
			position.y = -2
			position.x = -4
			$Sprite.flip_h = true
			$Sprite2.flip_h = true
			$Sprite2.position.x = 4
			set_draw_behind_parent(false)
	$Sprite.position.x = own_offset_x * faceRight
	$Sprite.position.y = own_offset_y

func set_count(value):
	pass
