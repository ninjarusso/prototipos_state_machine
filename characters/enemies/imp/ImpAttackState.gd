class_name ImpAttackState
extends State

@export var idle_state : State
@export var attack_area : Area2D

func _ready() -> void:
	owner.connect("player_in_range", player_in_range)
	
func player_in_range(body) -> void:
	emit_signal("interrupt_state", self)
	if body.has_method("take_damage"):
		body.take_damage(parent.damage)
	
	
func enter() -> void:
	super()
	anim_tree["parameters/conditions/attack"] = true
	

func exit() -> void:
	anim_tree["parameters/conditions/attack"] = false
