extends Area3D

func _ready():
	$Label3D.hide()

func _process(delta):
	$CollisionShape3D/MeshInstance3D.rotate_y(deg_to_rad(50)*delta)

func _on_body_entered(body):
	$CollisionShape3D/MeshInstance3D.hide()
	var d = global_position.distance_to(body.global_position)
	if d < 2.0:
		$Label3D.text  = "200"
		$Label3D.modulate = Color(1,1,0)
	elif d > 3.5:
		$Label3D.text  = "50"
	else:
		$Label3D.text  = "100"
	$Label3D.show()
	var tween = create_tween().set_parallel()
	tween.tween_property($Label3D,"modulate:a",0.0,0.5)
