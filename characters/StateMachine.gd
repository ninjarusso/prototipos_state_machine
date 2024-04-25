class_name StateMachine
extends Node

@export var starting_state : State
@export var current_state : State

func init(parent : CharacterBody2D) -> void:
	for child in get_children():
		child.parent = parent
		child.anim_tree = parent.animation_tree
		child.connect("interrupt_state", interrupt_state_change)
		
	change_state(starting_state)
	
func change_state(new_state : State) -> void:
	if current_state:
		current_state.exit()
		
	current_state = new_state
	current_state.enter()
	
func _physics_process(delta):
	if(current_state.next_state != null):
		change_state(current_state.next_state)
	
func process_physics(delta : float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
		
func process_input(event : InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta : float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
 
func interrupt_state_change(new_state : State) -> void:
	change_state(new_state)
