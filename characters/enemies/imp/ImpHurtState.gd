class_name ImpHurtState
extends State

@export var idle_state : State

func _ready():
	owner.connect("hurt", on_hit)
	
func on_hit():
	emit_signal("interrupt_state", self)
	
func enter():
	super()
	anim_tree["parameters/conditions/hurt"] = true
	
func process_physics(delta : float) -> State :
	process_movement()
	return null

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "hurt":
		emit_signal("interrupt_state", idle_state)

func process_movement() -> void:
	parent.velocity = parent.direction * move_speed
	
func exit() -> void:
	anim_tree["parameters/conditions/hurt"] = false
