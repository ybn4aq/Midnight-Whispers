extends TextureRect



# Called when the node enters the scene tree for the first time.
func _ready():
	if State.game_won_elphie:
		switch_scene_after_delay_elphie(1)
	elif State.game_won_ron:
		switch_scene_after_delay_ron(1)
	elif State.game_won_shawn:
		switch_scene_after_delay_shawn(1)


func switch_scene_after_delay_elphie(time_seconds):
	await get_tree().create_timer(time_seconds).timeout
	get_tree().change_scene_to_file("res://elphie_pre_bite.tscn")

func switch_scene_after_delay_ron(time_seconds):
	await get_tree().create_timer(time_seconds).timeout
	get_tree().change_scene_to_file("res://ron_pre_bite.tscn")

func switch_scene_after_delay_shawn(time_seconds):
	await get_tree().create_timer(time_seconds).timeout
	get_tree().change_scene_to_file("res://shawn_pre_bite.tscn")
