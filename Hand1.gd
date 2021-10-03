extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var offset_num = 0
	var faceRight = -1
	if !Utils.isAttacking:
		var frame_num = Utils.player.get_node("Sprite").frame / 4
		if Utils.player.direction == "Down" or Utils.player.direction == "Right":
			faceRight = 1
		match frame_num:
			1:
				offset_num = -1
			2:
				offset_num = -2
			4:
				offset_num = 1
			5:
				offset_num = 2
		if Utils.player.direction == "Down" or Utils.player.direction == "Up":
			Utils.player.weapon.get_node("Sprite").offset.y = offset_num * faceRight
			offset.y = offset_num * faceRight
		else:
			Utils.player.weapon.get_node("Sprite").offset.x = offset_num * faceRight
			offset.x = offset_num * faceRight
 
