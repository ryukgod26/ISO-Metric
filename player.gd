## The Main Class from where Player Inherits all the functionality.
class_name Player
extends CharacterBody2D

enum STATE{
	FALL,
	FLOOR,
	JUMP,
	DOUBLE_JUMP,
}

const FALL_GRAVITY := 1500.
const FALL_VELOCITY := 500.
const WALK_VELOCITY := 200.
const RUN_VELOCITY := 400.

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite

var active_state := STATE.FLOOR

func move_logic(_delta):
	move_and_slide()

func process_state(_delta):
	## This code will only run once the state is switched. It will not run continously.
	match active_state:
		STATE.FALL:
			pass 
		
		STATE.FLOOR:
			pass
		
		STATE.JUMP:
			pass
		
		STATE.DOUBLE_JUMP:
			pass

func switch_state(state: STATE):
	active_state = state

func handle_movement():
	var dirrection = Input.get_axis("move_up","move_down")
