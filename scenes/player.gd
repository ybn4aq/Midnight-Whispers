extends CharacterBody2D

var direction := Vector2.ZERO
@export var SPEED := 125.0

@onready var _animated_sprite = $AnimatedSprite2D
@onready var actionable_finder = $ActionableFinder

func _ready():
	add_to_group("player")

func read_input():
	if not State.in_dialogue:
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
