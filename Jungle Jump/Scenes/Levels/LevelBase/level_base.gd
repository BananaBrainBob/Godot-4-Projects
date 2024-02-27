extends Node2D

signal score_changed
var item_scene = load("res://Scenes/Item/item.tscn")
var score = 0: set = set_score

func set_score(new_score):
	score = new_score
	score_changed.emit(new_score)

func _ready():
	$TileMap_items.hide()
	$Player.reset($SpawnPoint.position)
	set_camera_limits()
	spawn_items()

func set_camera_limits():
	var World = $TileMap_world as TileMap
	var map_size = World.get_used_rect()
	var celll_size = World.tile_set.tile_size
	var cam = $Player/Camera2D as Camera2D
	cam.limit_left = (map_size.position.x - 5) * celll_size.x
	cam.limit_right = (map_size.end.x + 5) * celll_size.x

func spawn_items():
	var Items = $TileMap_items as TileMap
	var item_cells = Items.get_used_cells(0)
	for cell in item_cells:
		var data = Items.get_cell_tile_data(0,cell)
		var type = data.get_custom_data("type")
		var item = item_scene.instantiate()
		add_child(item)
		item.init(type,Items.map_to_local(cell))
		item.picked_up.connect(self._on_item_picked_up)

func _on_item_picked_up():
	score += 1

