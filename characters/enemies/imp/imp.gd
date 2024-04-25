class_name Imp
extends CharacterBody2D

@export var health : float = 7.0
@export var damage : float = 1.0

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : StateMachine = $StateMachine
@onready var sprite : Sprite2D = $Sprite2D

var direction : Vector2
var move_speed : float
var player : Player
var player_chase : bool = false
var is_dead : bool = false
signal hurt
signal dead
signal player_entered
signal player_exited
signal player_in_range

func _ready() -> void:
	animation_tree.active = true
	state_machine.init(self)
	
func _physics_process(delta):
	if !is_dead && player_chase:
		direction = player.position - position
		velocity = direction.normalized() * move_speed
	else:
		velocity = Vector2.ZERO
	update_facing_direction()
	move_and_collide(velocity * delta)
	
func take_damage(damage : float) -> void:
	health -= damage
	if health < 0:
		emit_signal("dead")
		is_dead = true
	else:
		print(self.name + " has taken " + str(damage) + " damage, " + str(health) + " hp remaining")
		emit_signal("hurt")

func _on_player_detection_body_entered(body):
	if !is_dead && body is Player:
		player = body
		player_chase = true
		emit_signal("player_entered")
		
func update_facing_direction() -> void:
	if direction.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

func _on_player_detection_body_exited(body):
	if !is_dead && body is Player:
		player = null
		player_chase = false
		emit_signal("player_exited")

func _on_attack_area_body_entered(body):
	if !is_dead && body is Player:
		emit_signal("player_in_range", body)

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "attack":
		emit_signal("player_entered")
