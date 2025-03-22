class_name StateMachine extends Node

@export var initialState: State = null

# Define the initial state in the editor.
# If it's not set, we use the 1st child node.
@onready var state: State = (func get_initial_state() -> State:
	return initialState if initialState != null else get_child(0)).call()

# Connect "finished" signal to each child node.
func _ready() -> void:
	for i: State in find_children("*", "State"):
		i.finished.connect(_next_state)
	await owner.ready
	state.enter("")

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func _next_state(nextState: String) -> void:
	if !has_node(nextState):
		printerr(owner.name + ": Trying to transition to state " + nextState + " but it does not exist.")
		return
	else:
		print(owner.name + ": Transitioning to " + nextState + ".")

	var prevState := state.name
	state.exit()
	state = get_node(nextState)
	state.enter(prevState)