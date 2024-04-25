class_name TokenMoveState
extends State

@export var idle_state : State

func enter() -> void:
	super()
	anim_tree["parameters/conditions/idle"] = false
	anim_tree["parameters/conditions/is_moving"] = true

func process_physics(delta : float) -> State:
	if parent.velocity == Vector2.ZERO:
		return idle_state
	return null
