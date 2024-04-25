class_name AttackState
extends State

@onready var attack_timer : Timer = $AttackTimer
@onready var buffer_timer : Timer = $BufferTimer

@export var attack1_anim : String = "attack1"
@export var attack2_anim : String = "attack2"
@export var idle_state : State

func enter() -> void:
	buffer_timer.start()
	attack_timer.start()
	anim_tree["parameters/playback"].travel(attack1_anim)
	parent.velocity = Vector2.ZERO
	
func process_physics(delta : float) -> State:
	if buffer_timer.is_stopped():
		parent.direction = Input.get_vector("left", "right", "up", "down")
	return null

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == attack1_anim):
		if(attack_timer.is_stopped()):
			emit_signal("interrupt_state", idle_state)
		else:
			anim_tree["parameters/playback"].travel(attack2_anim)
	if(anim_name == attack2_anim):
		emit_signal("interrupt_state", idle_state)

func process_input(event : InputEvent) -> State:
	if event.is_action_pressed("attack"):
		attack_timer.start()
		buffer_timer.start()
	return null
