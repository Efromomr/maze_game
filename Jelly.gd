extends TileMap

var cube = preload("res://JellyCube.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	place_tile_scenes()



func place_tile_scenes():
	var cube_tiles = get_used_cells_by_id(0)
	var cube_fron_tiles = get_used_cells_by_id(1)
	
	tiles_instancing(cube_tiles, cube)
	tiles_instancing(cube_fron_tiles, cube)
	
func tiles_instancing(tile_array, tile_scene):
	for tile in tile_array:
		var tile_instance = tile_scene.instance()
		tile_instance.position = map_to_world(tile)
		tile_instance.tile = tile
		add_child(tile_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
