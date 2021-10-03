extends Area2D

var collides = false
var damage = 5
var target_point
var faceRight = 1

func _ready():
	$Sprite.modulate = Color(1, 1, 1, 0.5)
	rotation_degrees = 0

func _physics_process(delta):
	if !Inventory.isAttacking:
		position = get_global_mouse_position() + Vector2(0,-10)
		if position.x < Utils.player.position.x:
			$Sprite.scale.x = -1
		else:
			$Sprite.scale.x = 1
	else:
		if abs(rotation_degrees) < abs(359):
			rotation_degrees += 720 * delta * faceRight
			position.x = target_point.x + cos(rotation) * 48 * faceRight
			position.y = target_point.y + sin(rotation) * 48 * faceRight
		else:
			Inventory.isAttacking = false
			$Sprite.modulate = Color(1, 1, 1, 0.5)
			$CollisionShape2D.disabled = false
			$Area2D/CollisionShape2D.disabled = true
			rotation_degrees = 0
		
func attack():
	if position.x < Utils.player.position.x:
		faceRight = -1
	else:
		faceRight = 1
	target_point = get_global_mouse_position()
	$Sprite.modulate = Color(1, 1, 1, 1)
	$CollisionShape2D.disabled = true
	$Area2D/CollisionShape2D.disabled = false
	
func _input(_input):
	if (Input.is_action_just_pressed("attack") and !collides):
		attack()
		Inventory.isAttacking = true
	

func _on_Area2D_body_entered(_body):
	$Sprite.visible = false
	collides = true

func _on_Area2D_body_exited(_body):
	$Sprite.visible = true
	collides = false
