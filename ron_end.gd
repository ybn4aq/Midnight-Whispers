extends Node

@onready var video_player = $VideoStreamPlayer

func _ready():
	video_player.play()
	WinMusic.play()
	switch_scene_after_delay(13.5)

func switch_scene_after_delay(time_seconds):
	await get_tree().create_timer(time_seconds).timeout
	get_tree().change_scene_to_file("res://godfrey_kill.tscn")
