extends TileMap

var door_scene = preload("res://Door.tscn")
var side_door_scene = preload("res://SideDoor.tscn")


func place_tile_scenes():
	var front_door_tiles = get_used_cells_by_id(3)
	var side_door_tiles = get_used_cells_by_id(1)
	
	tiles_instancing(front_door_tiles, door_scene)
	tiles_instancing(side_door_tiles, side_door_scene)
	
func tiles_instancing(tile_array, tile_scene):
	for tile in tile_array:
		var tile_instance = tile_scene.instance()
		tile_instance.position = map_to_world(tile)
		tile_instance.tile = tile
		add_child(tile_instance)
