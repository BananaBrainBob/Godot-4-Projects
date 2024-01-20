extends CharacterBody3D

signal dead
signal fuel_changed
signal score_changed

var title_screen = "res://Scenes/title_screen.tscn"

@export var fuel_burn = 1.0
@export var pitch_speed = 1.1
@export var roll_speed = 2.5
@export var level_speed = 4.0
@export var forward_speed = 25
@onready var explosion = $Explosion
var pitch_input
var roll_input
var max_altitude = 20 
var max_fuel = 10.0
var fuel = 10.0:
	set = set_fuel
var score = 0:
	set = set_score

func _physics_process(delta):
	get_input(delta)
	rotation.x = lerpf(rotation.x,pitch_input,pitch_speed*delta)
	rotation.x =clamp(rotation.x,deg_to_rad(-45),deg_to_rad(45))
	$cartoon_plane.rotation.z = lerpf($cartoon_plane.rotation.z,roll_input,roll_speed*delta)
	velocity = -transform.basis.z * forward_speed
	velocity += transform.basis.x * $cartoon_plane.rotation.z / deg_to_rad(45) * forward_speed / 2.0
	fuel -= fuel_burn * delta
	move_and_slide()
	if get_slide_collision_count() > 1:
		die()

func get_input(_delta):
	pitch_input = Input.get_axis("pitch_down","pitch_up")
	roll_input = Input.get_axis("roll_left","roll_right")
	if position.y >= max_altitude and pitch_input > 0:
		position.y = max_altitude
		pitch_input = 0

func die():
	set_physics_process(false)
	$cartoon_plane.hide()
	explosion.show()
	explosion.play("default")
	$AudioStreamPlayer.play()
	await(explosion.animation_finished)
	explosion.hide()
	dead.emit()
	get_tree().change_scene_to_file(title_screen)

func set_fuel(value):
	fuel = min(value,max_fuel)
	fuel_changed.emit(fuel)
	if fuel <= 0:
		die()

func set_score(value):
	score = value
	score_changed.emit(score)
