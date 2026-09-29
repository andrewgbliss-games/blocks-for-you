class_name CharacterInput extends Node2D

var movement_direction: Vector2
var aim_direction: Vector2

func get_movement_direction() -> Vector2:
	return movement_direction

func get_aim_direction() -> Vector2:
	return aim_direction

func is_action_pressed(_name: String) -> bool:
	return false
