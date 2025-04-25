extends Area2D


@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@export var radius := 8.0
@export var npc: CharacterBody2D

func action(direction) -> void:
	if npc.has_method("face_player"):
		npc.face_player(direction)
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)
	State.met_charles = true
