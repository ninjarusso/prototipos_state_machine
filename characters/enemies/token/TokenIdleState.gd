class_name TokenIdleState
extends State

@export var move_state : State


func enter() -> void:
	super()
	anim_tree["parameters/conditions/idle"] = true
	anim_tree["parameters/conditions/is_moving"] = false
	parent.velocity = Vector2.ZERO

func process_physics(delta : float) -> State:
	if parent.player != null:
		next_state = move_state
	return null
