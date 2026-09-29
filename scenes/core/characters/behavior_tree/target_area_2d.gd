extends Area2D

@export var bt_player: BTPlayer
@export var target_var: StringName = &"target"
@export var group_var: StringName = &"player"
@export var raycast: RayCast2D
@export var require_raycast: bool = false

var target_node

func _ready() -> void:
	if require_raycast:
		raycast.enabled = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _process(_delta: float) -> void:
	if require_raycast and target_node:
		raycast.target_position = target_node.global_position - global_position
		if raycast.is_colliding():
			_on_body_exited(target_node)

func _on_body_entered(body):
	if body.is_in_group(group_var):
		target_node = body
		if require_raycast:
			raycast.enabled = true
			raycast.target_position = body.global_position - global_position
			if not raycast.is_colliding():
				bt_player.blackboard.set_var(target_var, body)
			else:
				raycast.enabled = false
		else:
			bt_player.blackboard.set_var(target_var, body)
	
func _on_body_exited(body):
	if target_node == body:
		target_node = null
		if require_raycast:
			raycast.enabled = false
		bt_player.blackboard.erase_var(target_var)
