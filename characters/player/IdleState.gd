class_name IdleState
extends State

@export var move_state : State
@export var attack_state : State
@export var roll_state : State

func enter() -> void:
	super()
	anim_tree["parameters/conditions/idle"] = true
	anim_tree["parameters/conditions/is_moving"] = false

func process_physics(delta : float) -> State:
	process_movement()
	if (parent.direction != Vector2.ZERO):
		return move_state
	return null

func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack_state
	return null

func process_movement() -> void:
	parent.direction = Input.get_vector("left", "right", "up", "down")
	parent.velocity = parent.direction * move_speed
