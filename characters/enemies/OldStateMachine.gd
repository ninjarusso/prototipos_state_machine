class_name OldStateMachine
extends Node2D

@export var character : CharacterBody2D
@export var current_state : State
@export var animation_tree : AnimationTree

var states : Array[State]

func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			child.parent = character
			child.anim_tree = animation_tree
			child.connect("interrupt_state", on_state_interrupt_state)
		else:
			push_warning("Child " + child.name + " is not State for CharacterStateMachine")
			
func _physics_process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	current_state.state_process(delta)

func switch_states(new_state : State):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
		
	current_state = new_state
	current_state.on_enter()

func _input(event: InputEvent):
	current_state.state_input(event)

func check_if_can_move():
	return current_state.can_move

func check_if_can_take_damage():
	return current_state.can_take_damage
	
func on_state_interrupt_state(new_state : State):
	switch_states(new_state)
