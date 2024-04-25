class_name ImpIdleState
extends State

func enter() -> void:
	super()
	anim_tree["parameters/conditions/idle"] = true
	anim_tree["parameters/conditions/is_moving"] = false
	parent.velocity = Vector2.ZERO
