class_name MoveState
extends State

@export var idle_state : State
@export var attack_state : State
@export var roll_state : State

func enter() -> void:
	super()
	anim_tree["parameters/conditions/idle"] = false
	anim_tree["parameters/conditions/is_moving"] = true
	
func process_physics(delta : float) -> State :
	process_movement()
	if (parent.direction == Vector2.ZERO):
		return idle_state
	return null
	
func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack_state
	if event.is_action_pressed("special action"):
		return roll_state
	return null

func process_movement() -> void:
	parent.direction = Input.get_vector("left", "right", "up", "down")
	parent.velocity = parent.direction * move_speed
