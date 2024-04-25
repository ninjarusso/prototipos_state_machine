class_name Token
extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : StateMachine = $StateMachine
@onready var sprite : Sprite2D = $Sprite2D

signal hurt
signal dead

var direction : Vector2
var player : Player
var move_speed : float
var is_dead : bool = false
var health : float = 14.0

func _ready() -> void:
	animation_tree.active = true
	state_machine.init(self)

func _physics_process(delta):
	if player != null:
		direction = player.position - position
		velocity = direction.normalized() * move_speed
	update_facing_direction()
	move_and_slide()

func update_facing_direction() -> void:
	if direction.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

func take_damage(damage : float) -> void:
	health -= damage
	if health < 0:
		emit_signal("dead")
		is_dead = true
	else:
		print(self.name + " has taken " + str(damage) + " damage, " + str(health) + " hp remaining")
		emit_signal("hurt")


func _on_detection_area_body_entered(body):
	if body is Player:
		player = body
		print(player.name)


func _on_detection_area_body_exited(body):
	if body is Player:
		player = null
