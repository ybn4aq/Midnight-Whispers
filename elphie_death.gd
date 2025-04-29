extends TextureRect

@onready var loading_screen = $LoadingScreen
@onready var press_z = $PressZ



func _ready() -> void:
	loading_screen.visible = false
	press_z.visible = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("accept"):
		loading_screen.visible = true
		press_z.visible = false
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://scenes/night_1.tscn")
