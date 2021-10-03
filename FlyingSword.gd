extends KinematicBody2D

enum {
	SLASH,
	PIKE,
	IDLE
}
var state = IDLE
var faceRight = 1
var player = Utils.player
var target_point
var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Enemies")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		SLASH:
			if abs(rotation_degrees) < abs(120):
				rotation_degrees += 720 * delta * faceRight
				position.x = target_point.x + cos(rotation) * 12 * faceRight
				position.y = target_point.y + sin(rotation) * 12 * faceRight
			else:
				state = PIKE
		PIKE:
			move_and_collide(velocity)
			accelerate_towards_point(Utils.player.position)
		IDLE:
			pass

func accelerate_towards_point(point):
	var direction = global_position.direction_to(point)
	velocity = direction 
	$Sprite.flip_v = velocity.x < 0
	rotation = direction.angle() + 0.5 * faceRight

func _on_Area2D_area_entered(area):
	target_point = position
	state = SLASH
	
func awake():
	state = PIKE
func asleep():
	state = IDLE
