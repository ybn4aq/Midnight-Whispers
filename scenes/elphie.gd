extends CharacterBody2D

@export var SPEED := 25.0
@export var MOVE_TIME := 0.5
@export var WAIT_TIME := 4.0
@onready var _animated_sprite = $AnimatedSprite2D
var direction := Vector2.ZERO
var state := "idle"
var move_timer := 0.0
@onready var _player_detector = $PlayerDetector
@onready var _label = $Label
var has_switched_text = false

func _ready():
	_label.visible = false
	_player_detector.body_entered.connect(_on_player_entered)
	_player_detector.body_exited.connect(_on_player_exited)
	randomize()
	if State.in_dialogue:
		state = "idle"

func _physics_process(delta):
	if State.met_elphie and not has_switched_text:
		_label.text = str("Elphie")
		has_switched_text = true
		
	match state:
		"idle":
			move_timer -= delta
			if move_timer <= 0:
				_pick_new_direction()
		"moving":
			velocity = direction * SPEED
			move_and_slide()
			move_timer -= delta
			if move_timer <= 0:
				_stop_moving()

func _pick_new_direction():
	if not State.in_dialogue:
		var choices = [
			Vector2.UP,
			Vector2.DOWN,
			Vector2.LEFT,
			Vector2.RIGHT,
			Vector2.ZERO
		]
		direction = choices[randi() % choices.size()]
		
		if direction == Vector2.ZERO:
			state = "idle"
			move_timer = WAIT_TIME
		else:
			state = "moving"
			move_timer = MOVE_TIME
			_update_walk_animation()

func _stop_moving():
	velocity = Vector2.ZERO
	state = "idle"
	move_timer = WAIT_TIME
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

func face_player(player_direction: Vector2):
	var npc_facing = -player_direction

	if abs(npc_facing.x) > abs(npc_facing.y):
		_animated_sprite.flip_h = npc_facing.x < 0
		_animated_sprite.play("idle_side")
	else:
		if npc_facing.y > 0:
			_animated_sprite.play("idle_down")
		else:
			_animated_sprite.play("idle_up")

func _on_player_entered(body: Node):
	if body.is_in_group("player"):
		_label.visible = true

func _on_player_exited(body: Node):
	if body.is_in_group("player"):
		_label.visible = false
