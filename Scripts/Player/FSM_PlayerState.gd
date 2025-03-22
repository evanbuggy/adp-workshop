class_name FSM_PlayerState extends State

const IDLE = "FSM_Idle"
const RUNNING = "FSM_Running"
const JUMPING = "FSM_Jumping"
const DOUBLE_JUMP = "FSM_DoubleJump"

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The FSM_PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")