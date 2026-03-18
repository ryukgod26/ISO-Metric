extends CharacterBody2D

const SPEED = 16
@onready var ray_cast: RayCast2D = $RayCast

func _physics_process(_delta: float) -> void:
	var dir = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if dir != Vector2.ZERO:
		velocity = dir * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _process(_delta: float) -> void:
	ray_cast.target_position = get_local_mouse_position()
	
	if Input.is_action_just_pressed("ui_accept"):
		snap_photo()

func snap_photo():
	ray_cast.force_raycast_update()
	
	if ray_cast.is_colliding():
		var hit_obj = ray_cast.get_collider()
		
		if hit_obj.is_in_group("GlitchObjects"):
			print("Glitch Object Captured")
			hit_obj.queue_free()
		else:
			print("Just a Normal Photo")
