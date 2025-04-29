extends TextureRect

func _ready():
	switch_scene_after_delay(1)

func switch_scene_after_delay(time_seconds):
	await get_tree().create_timer(time_seconds).timeout
	get_tree().change_scene_to_file("res://shawn_bite.tscn")
