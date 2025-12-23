extends ProgressBar

var health := 0: set = _health_changed
@onready var damage_bar: ProgressBar = $DamageBar
@onready var timer: Timer = $Timer

func intial_health(_health):
	health = _health
	value = health
	max_value = health
	damage_bar.value = health
	damage_bar.max_value = health

func _health_changed(new_health):
	var prev_health = health
	 
	health = min(max_value, new_health)
	
	if health <= 0:
		queue_free()
	
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health
	

func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(damage_bar,"value", health, 0.2)
