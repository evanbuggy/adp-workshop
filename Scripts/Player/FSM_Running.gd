extends FSM_PlayerState

var node_dustParticle = preload("res://Scenes/Particle/Dust.tscn")
var dustCurrFrame := 0

func enter(_prevState: String) -> void:
	dustCurrFrame = player.dustTimer

func handle_input(_event: InputEvent) -> void:
	player.set_input_vec()

func physics_update(delta) -> void:
	# Determines when to spawn a dust particle.
	if (dustCurrFrame >= player.dustTimer):
		var dustParticle = node_dustParticle.instantiate();
		dustParticle.position = player.position
		add_child(dustParticle)
		dustCurrFrame = 0
	else:
		dustCurrFrame += 1

	if player.inputVec == Vector2.ZERO:
		finished.emit(IDLE)

	player.input_to_horizontal_movement(delta)
	player.horizontal_movement(delta)

	if (!player.is_on_floor()):
		player.velocity.y -= player.gravity * delta
	
	if (Input.is_action_just_pressed("ui_accept")):
		finished.emit(JUMPING)

	player.move_and_slide()

func exit() -> void:
	player.inputVec = Vector2.ZERO