extends Node3D

var chunk =  preload("res://Scenes/Chunk.tscn")
var num_chunks = 1
var chunk_size = 200
var max_position = -100

func _process(_delta):
	if $Plane.position.z < max_position:
		num_chunks += 1
		var new_chunk = chunk.instantiate()
		new_chunk.position.z = max_position - chunk_size / 2.0
		new_chunk.level = floor(num_chunks / 4.0)
		add_child(new_chunk)
		max_position -= chunk_size
