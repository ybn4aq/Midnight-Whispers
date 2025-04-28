extends CharacterBody2D

var direction := Vector2.ZERO
@export var SPEED := 125.0

@onready var _animated_sprite = $AnimatedSprite2D
@onready var actionable_finder = $ActionableFinder
@onready var secret_menu = $SecretMenu
@onready var franklin_secret = $SecretMenu/FranklinSecret
@onready var rachel_secret = $SecretMenu/RachelSecret
@onready var julie_secret = $SecretMenu/JulieSecret
@onready var ben_secret = $SecretMenu/BenSecret
@onready var boo_secret = $SecretMenu/BooSecret
@onready var greg_secret = $SecretMenu/GregSecret
@onready var clara_secret = $SecretMenu/ClaraSecret
@onready var eugene_secret = $SecretMenu/EugeneSecret
@onready var charles_secret = $SecretMenu/CharlesSecret
@onready var bjorn_secret = $SecretMenu/BjornSecret
@onready var sean_secret = $SecretMenu/SeanSecret
@onready var spike_secret = $SecretMenu/SpikeSecret

var show_menu = false

func _ready():
	secret_menu.visible = show_menu
	add_to_group("player")
	franklin_secret.text = str("?????")
	rachel_secret.text = str("?????")
	julie_secret.text = str("?????")
	ben_secret.text = str("?????")
	boo_secret.text = str("?????")
	clara_secret.text = str("?????")
	greg_secret.text = str("?????")
	eugene_secret.text = str("?????")
	charles_secret.text = str("?????")
	bjorn_secret.text = str("?????")
	sean_secret.text = str("?????")
	spike_secret.text = str("?????")
	State.secret_learned.connect(_on_secret_learned)
	
	

func _on_secret_learned(character):
	print("hello")
	match character:
		"franklin":
			franklin_secret.text = str("Franklin: Eugene married four times and has cheated on each of his wives.")
		"rachel":
			rachel_secret.text = str("Rachel: Ben hacked into his school and looked at everyone's search histories.")
		"julie":
			julie_secret.text = str("Julie: No one would notice if Ron disappeared one day.")
		"ben":
			ben_secret.text = str("Ben: Julie has been researching how to \"socially ruin\" someone's life.")
		"boo":
			boo_secret.text = str("Boo: Spike is stealing songs from Boo.")
		"clara":
			clara_secret.text = str("Clara: Boo steals from her parents.")
		"greg":
			greg_secret.text = str("Greg: Shawn is planning on leaving town without telling anybody.")
		"eugene":
			eugene_secret.text = str("Eugene: Charles lied about going to war.")
		"charles":
			charles_secret.text = str("Charles: Bjorn thinks his ship made it to Greenland, but it actually crashed here.")
		"bjorn":
			bjorn_secret.text = str("Bjorn: Elphie thinks she actually has magical powers.")
		"sean":
			sean_secret.text = str("Sean: Rachel drives illegally.")
		"spike":
			spike_secret.text = str("Spike: Greg's manhood leaves much to be desired.")
		_:
			print(str(character) + "Not recognized under secret_learned signal emission")
			
		

func read_input():
	if not State.in_dialogue:
		if not show_menu:
			var input_vector := Vector2.ZERO

			if Input.is_action_pressed("up"):
				input_vector.y -= 1
			elif Input.is_action_pressed("down"):
				input_vector.y += 1

			if Input.is_action_pressed("left"):
				input_vector.x -= 1
			elif Input.is_action_pressed("right"):
				input_vector.x += 1
			
			

			input_vector = input_vector.normalized()

			if input_vector != Vector2.ZERO:
				direction = input_vector
				velocity = input_vector * SPEED
				_update_walk_animation()
			else:
				velocity = Vector2.ZERO
				_update_idle_animation()
		if Input.is_action_just_released("secret_menu"):
			show_menu = !show_menu
			secret_menu.visible = show_menu
	

func _update_walk_animation():
	if direction.y < 0:
		_play_animation_if_needed("walk_up")
	elif direction.y > 0:
		_play_animation_if_needed("walk_down")
	elif direction.x != 0:
		_animated_sprite.flip_h = direction.x < 0
		_play_animation_if_needed("walk_side")

func _update_idle_animation():
	if direction.y < 0:
		_play_animation_if_needed("idle_up")
	elif direction.y > 0:
		_play_animation_if_needed("idle_down")
	elif direction.x != 0:
		_animated_sprite.flip_h = direction.x < 0
		_play_animation_if_needed("idle_side")

func _play_animation_if_needed(name: String):
	if _animated_sprite.animation != name or !_animated_sprite.is_playing():
		_animated_sprite.play(name)

func _physics_process(delta: float) -> void:
	read_input()
	update_actionable_finder_position()
	move_and_slide()

func update_actionable_finder_position():
	var offset_distance := 16
	actionable_finder.position = direction.normalized() * offset_distance


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			if actionables[0].has_method("action"):
				actionables[0].action(direction)
				State.in_dialogue = true
				_update_idle_animation()
