class_name DebugLabel
extends Label

@export var state_machine : StateMachine

func _process(delta):
	text = "State: " + state_machine.current_state.name
