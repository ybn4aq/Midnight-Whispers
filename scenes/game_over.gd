extends Node2D


@onready var loading_screen = $LoadingScreen
@onready var game_over_screen = $GameOverScreen
@onready var game_over_sound = $GameOverSound
@onready var press_z = $PressZ


func _ready() -> void:
	loading_screen.visible = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("accept"):
		game_over_sound.stop()
		game_over_screen.visible = false
		press_z.visible = false
		loading_screen.visible = true
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://scenes/night_1.tscn")
		
