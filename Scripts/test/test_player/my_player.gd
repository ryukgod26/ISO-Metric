extends CharacterBody2D

const SPEED = 16

func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if dir != Vector2.ZERO:
		velocity = dir * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()
