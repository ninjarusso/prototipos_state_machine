class_name ImpMoveState
extends State

@export var idle_state : State
@export var attack_state : State

func _ready():
	owner.connect("player_entered", on_player_entered)
	owner.connect("player_exited", on_player_exited)

func enter() -> void:
	super()
	anim_tree["parameters/conditions/idle"] = false
	anim_tree["parameters/conditions/is_moving"] = true
	
func process_physics(delta : float) -> State:
	print(str(owner.direction.length()))
	if owner.direction.length() < 40:
		return attack_state
	return null

func on_player_entered() -> void:
	emit_signal("interrupt_state", self)
	
func on_player_exited() -> void:
	emit_signal("interrupt_state", idle_state)
