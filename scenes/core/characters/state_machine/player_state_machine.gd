class_name PlayerStateMachine extends LimboHSM

@onready var idle_state: LimboState = $IdleState
@onready var move_state: LimboState = $MoveState

func _ready() -> void:
	_init_state_machine()

func _init_state_machine() -> void:
	add_transition(idle_state, move_state, "move_start")
	add_transition(move_state, idle_state, "move_stop")

	initialize(get_parent())
	initial_state = idle_state
	set_active(true)
