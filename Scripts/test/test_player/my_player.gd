extends CharacterBody2D

const SPEED = 16
@onready var ray_cast: RayCast2D = $RayCast
@onready var lens_mask: Sprite2D = $hiddenWorldContainer/LensMask
@onready var hidden_world_anchor: Node2D = $hiddenWorldContainer/LensMask/HiddenWorldAnchor

@onready var hud = $HUD/CameraUI
@onready var battery_bar = $HUD/CameraUI/BatteryBar
@onready var credits_label = $HUD/CameraUI/DataCredits
@onready var rec_dot = $HUD/CameraUI/RecDot

var data_credits: int = 0
var max_battery: float = 100.0
var current_battery: float = 100.0
var is_aiming: bool = false

func _ready() -> void:
	lens_mask.visible = false
	battery_bar.max_value = max_battery
	battery_bar.value = current_battery
	update_score_display()
	hud.visible = false

func _physics_process(_delta: float) -> void:
	var dir = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if dir != Vector2.ZERO:
		velocity = dir * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _process(delta: float) -> void:
	ray_cast.target_position = get_local_mouse_position()
	
	if Input.is_action_just_pressed("aim_camera"):
		lens_mask.visible = true
		update_lens_position()
	else:
		lens_mask.visible = false
	
	if Input.is_action_just_pressed("ui_accept"):
		snap_photo()
	
	if Input.is_action_pressed("aim_camera"):
		is_aiming = true
		hud.visible = true
		drain_battery(delta)
		blink_rec_dot()
	else:
		is_aiming = false
		hud.visible = false
		
	if is_aiming and Input.is_action_just_pressed("ui_accept") and current_battery > 10:
		snap_photo()

func update_lens_position():
	var target_pos = get_global_mouse_position()
	lens_mask.global_position = target_pos
	hidden_world_anchor.global_position = Vector2.ZERO

func snap_photo():
	current_battery -= 10.0
	ray_cast.force_raycast_update()
	
	if ray_cast.is_colliding():
		var hit_obj = ray_cast.get_collider()
		
		if hit_obj.is_in_group("GlitchObjects"):
			print("Glitch Object Captured")
			hit_obj.queue_free()
		else:
			print("Just a Normal Photo")

func save_image_to_disk() -> void:
	var img = get_viewport().get_texture().get_image()
	var time_string = Time.get_datetime_string_from_system().replace(":","-")
	var file_path = "user://iso_capture_" + time_string + ".png"
	
	img.save_png(file_path)
	print("Photo Saved Successfully")

func update_score_display():
	credits_label.text = "DATA: " + str(data_credits) + " TB"
	battery_bar.value = current_battery

func blink_rec_dot():
	var time_msec = Time.get_ticks_msec()
	if time_msec % 1000 < 500:
		rec_dot.visible = true
	else:
		rec_dot.visible = false

func drain_battery(amount_to_drain):
	current_battery -= amount_to_drain * 5.0 
	battery_bar.value = current_battery
