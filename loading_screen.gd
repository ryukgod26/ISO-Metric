class_name LoadingScreen
extends Node

var level
var progress = []
var screen_load_status = 0

@onready var progress_text: Label = $ProgressText
@onready var progress_bar: ProgressBar = $ProgressBar

func _process(delta: float) -> void:
	screen_load_status = ResourceLoader.load_threaded_get_status(level,progress)
	progress_bar.value = floor(progress[0] * 100)
	progress_text.text = str(floor(progress[0] * 100)) + "%"
	if screen_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(level)
		get_tree().change_scene_to_file(new_scene)
