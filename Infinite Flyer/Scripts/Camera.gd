extends Camera3D

@export var target_path : NodePath
@export var offset = Vector3.ZERO
var targtet = null

func _ready():
	if target_path:
		targtet = get_node(target_path)
		position = targtet.position + offset
		look_at(targtet.position)

func _physics_process(_delta):
	if !targtet:
		return
	position = targtet.position + offset
