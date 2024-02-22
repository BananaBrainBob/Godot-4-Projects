extends CharacterBody2D

@export var gravity := 750
@export var run_speed := 150
@export var jump_speed := -300

@onready var anim_player := $AnimationPlayer
@onready var sprite := $Sprite2D

enum {IDLE,RUN,JUMP,HURT,DEAD}
var state := IDLE 

func _ready() -> void:
	change_state(IDLE)

func _physics_process(delta : float) -> void:
	velocity.y += gravity * delta
	get_input()
	move_and_slide()
	if state == JUMP and is_on_floor():
		change_state(IDLE)
	if state == JUMP and velocity.y > 0:
		anim_player.play("jump_down")

func reset(_position : Vector2) -> void:
	position = _position
	show()
	change_state(IDLE)

func change_state(new_state) -> void:
	state = new_state
	match state:
		IDLE:
			anim_player.play("idle")
		RUN:
			anim_player.play("run")
		HURT:
			anim_player.play("hurt")
		JUMP:
			anim_player.play("jump_up")
		DEAD:
			hide()

func get_input() -> void:
	var right : bool = Input.is_action_pressed("right")
	var left : bool = Input.is_action_pressed("left")
	var jump : bool = Input.is_action_just_pressed("jump")
	#movement occurs in all states
	velocity.x = 0
	if right:
		velocity.x += run_speed
		sprite.flip_h = false
	if left:
		velocity.x -= run_speed
		sprite.flip_h = true
	# onlly allow jumping when on floor
	if jump and is_on_floor():
		change_state(JUMP)
		velocity.y = jump_speed
	#IDLE transitions to RUN when moving
	if state == IDLE and velocity.x != 0:
		change_state(RUN)
	#RUN transition to IDLE when standing still
	if state == RUN and velocity.x == 0:
		change_state(IDLE)
	#transition to JUMP when in air
	if state in [IDLE,RUN] and !is_on_floor():
		change_state(JUMP)
	
