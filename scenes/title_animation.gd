extends Control

@onready var flashing_label = $FlashingLabel
@onready var flash_timer = $FlashTimer

var texture_a: Texture2D
var texture_b: Texture2D
var showing_a := true

func _ready():
	texture_a = preload("res://assets/Midnight_Whispers_title.png")
	texture_b = preload("res://assets/Midnight_Whispers_title_2.png")
	
	flashing_label.texture = texture_a
	flash_timer.timeout.connect(_on_flash_timer_timeout)

func _on_flash_timer_timeout():
	showing_a = !showing_a
	flashing_label.texture = texture_a if showing_a else texture_b

func _process(_delta):
	# Check for "Z" press
	if Input.is_action_just_pressed("start_game"):
		get_tree().change_scene_to_file("res://scenes/night_1.tscn")
