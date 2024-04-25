class_name State
extends Node

@export var move_speed : float

signal interrupt_state(new_state : State)
var parent : CharacterBody2D
var anim_tree : AnimationTree
var next_state : State

func enter() -> void:
	parent.move_speed = move_speed
	pass
	
func exit() -> void:
	pass

func process_input(event : InputEvent) -> State:
	return null

func process_physics(delta : float) -> State:
	return null
	
func process_frame(delta : float) -> State:
	return null
