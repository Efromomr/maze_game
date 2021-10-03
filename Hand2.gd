extends Sprite


func _process(delta):
	var offset_num = 0
	var faceRight = 1
	if !Utils.isAttacking:
		if Utils.player.direction == "Down" or Utils.player.direction == "Up":
			visible = true
		else:
			visible = false
		var frame_num = Utils.player.get_node("Sprite").frame / 4
		if Utils.player.direction == "Down":
			position = Vector2(5,2)
			set_draw_behind_parent(false)
		else:
			position = Vector2(-5,2)
			faceRight = -1
			set_draw_behind_parent(true)
		match frame_num:
			1:
				offset_num = 1
			2:
				offset_num = 2
			4:
				offset_num = -1
			5:
				offset_num = -2
		offset.y = offset_num * faceRight
