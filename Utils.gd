extends Node

var map_active = false

var faceRight 
var droppedItem = preload("res://Drop.tscn")
var isAttacking = false

var current_room_coords_x = 0 setget set_current_rooms_x
var current_room_coords_y = 0 setget set_current_rooms_y

var old_room_coords_x = 0 setget set_old_rooms_x
var old_room_coords_y = 0 setget set_old_rooms_y

var player setget ,_get_player

func _get_player():
	return player if is_instance_valid(player) else null

func set_current_rooms_x(value):
	current_room_coords_x = int(value)
	
func set_current_rooms_y(value):
	current_room_coords_y = int(value)
	
func set_old_rooms_x(value):
	old_room_coords_x = int(value)
	
func set_old_rooms_y(value):
	old_room_coords_y = int(value)
	
func random_choice(array):
	return array[randi() % array.size()]

func drop_item(item_name, item_pos, item_type, quantity = 1):
	var drop = droppedItem.instance()
	var sprite = load("res://Items/" + item_name + ".png")
	drop.item_id = item_name
	drop.quantity = quantity
	drop.item_type = item_type
	drop.get_node("Sprite").set_texture(sprite)
	drop.global_position = item_pos
	get_tree().get_root().call_deferred("add_child", drop)

func spawn_enemy(enemy_name, enemy_pos):
	var enemy_scene = load("res://" + enemy_name + ".tscn")
	var enemy_instance = enemy_scene.instance()
	enemy_instance.global_position = enemy_pos
	get_tree().get_root().get_node("Maze").add_child(enemy_instance)
	
func activate_buttons():
	get_tree().get_root().get_node("Maze/CanvasLayer/Control/MiniMap").activate_buttons()
