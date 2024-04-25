class_name RollState
extends State

@export var idle_state : State

func enter() -> void:
	super()
	anim_tree["parameters/conditions/roll"] = true
	
func process_physics(delta : float) -> State:
	process_movement()
	return null
	
func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "roll":
		anim_tree["parameters/conditions/roll"] = false
		emit_signal("interrupt_state", idle_state)

func process_movement() -> void:
	parent.velocity = parent.direction * move_speed
