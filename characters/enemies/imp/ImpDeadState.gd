class_name ImpDeadState
extends State

func _ready() -> void:
	owner.connect("dead", on_dead)
	
func on_dead() -> void:
	emit_signal("interrupt_state", self)
	set_physics_process(false)
	
func enter() -> void:
	anim_tree["parameters/conditions/dead"] = true
