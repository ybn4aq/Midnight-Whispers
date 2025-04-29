extends Control

@onready var flashing_label = $FlashingLabel
@onready var flash_timer = $FlashTimer
@onready var splash_screens = $SplashScreens
@onready var control_screen = $ControlScreen
@onready var loading_screen = $LoadingScreen
@onready var press_z = $PressZ

var texture_a: Texture2D
var texture_b: Texture2D
var texture_c: Texture2D
var texture_d: Texture2D
var texture_e: Texture2D
var texture_f: Texture2D
var texture_g: Texture2D
var textures: Array
var texture_idx = -1
var showing_a := true

func _ready():
	splash_screens.visible = false
	control_screen.visible = false
	loading_screen.visible = false
	press_z.visible = false
	
	texture_a = preload("res://assets/Midnight_Whispers_title.png")
	texture_b = preload("res://assets/Midnight_Whispers_title_2.png")
	texture_c = preload("res://assets/midnight_whispers_exposition-1.png")
	texture_d = preload("res://assets/midnight_whispers_exposition-2.png")
	texture_e = preload("res://assets/midnight_whispers_exposition-3.png")
	texture_f = preload("res://assets/midnight_whispers_exposition-4.png")
	texture_g = preload("res://assets/Controls.png")
	textures = [texture_c, texture_d, texture_e, texture_f, texture_g, texture_g]
	
	flashing_label.texture = texture_a
	flash_timer.timeout.connect(_on_flash_timer_timeout)

func _on_flash_timer_timeout():
	showing_a = !showing_a
	flashing_label.texture = texture_a if showing_a else texture_b

func _process(_delta):
	if Input.is_action_just_pressed("start_game"):
		texture_idx += 1
		flashing_label.visible = false
		splash_screens.visible = true
		if texture_idx < len(textures) - 1:
			press_z.visible = true
		
		if texture_idx >= len(textures) - 1:
			press_z.visible = false
			splash_screens.visible = false
			control_screen.visible = false
			loading_screen.visible = true
			await get_tree().process_frame
			get_tree().change_scene_to_file("res://scenes/night_1.tscn")

		elif texture_idx == 4:
			control_screen.visible = true
			splash_screens.visible = false
		else:
			splash_screens.texture = textures[texture_idx]
