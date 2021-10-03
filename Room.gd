extends Node2D

export(NodePath) var background 

class_name Room
var coords_x
var coords_y
var treasure_room = false
var has_monsters = false
var monster_count = 0 setget set_monster_count
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	add_to_group("rooms")
	background = get_node(background)
	for x in range (1, 30):
		for y in range(6, 26):
			background.set_cell(x, y, 0)
	background.update_bitmask_region()
	
	
var chest_scene = preload("res://Tiles/Chest.tscn")

func place_tile_scenes():
	pass

	
func tiles_instancing(tile_array, tile_scene):
	for tile in tile_array:
		var tile_instance = tile_scene.instance()
		tile_instance.position = $Foreground.map_to_world(tile)
		tile_instance.tile = tile
		add_child(tile_instance)
		
func freeze():
	$Sprite.visible = true
	
func unfreeze():
	$Sprite.visible = false
	
func room_entered():
	if has_monsters:
		get_tree().call_group("doors", "close_door")
	else:
		get_tree().call_group("doors", "random_open")
	var children = get_children()
	for node in children:
		if node.is_in_group("Enemies"):
			node.awake()
			
	
	

func room_exited():
	var children = get_children()
	for node in children:
		if node.is_in_group("Enemies"):
			node.asleep()
	

func spawn_enemy(enemy_name, enemy_pos):
	var enemy_scene = load("res://" + enemy_name + ".tscn")
	var enemy_instance = enemy_scene.instance()
	enemy_instance.global_position = enemy_pos
	add_child(enemy_instance)
	
func set_monster_count(value):
	monster_count = value
	if monster_count <=0:
		has_monsters = false
		get_tree().call_group("doors", "random_open")

