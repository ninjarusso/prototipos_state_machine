class_name HitBox
extends Area2D

@export var damage : float = 3.0
@export var facing_shape : CollisionShape2D
@export var parent : Player

func _ready() -> void:
	parent.connect("facing_direction_changed", _on_player_facing_direction_changed)
	
func _on_player_facing_direction_changed(facing_right : bool) -> void:
	if facing_right:
		facing_shape.position = facing_shape.facing_right_position
	else:
		facing_shape.position = facing_shape.facing_left_position
