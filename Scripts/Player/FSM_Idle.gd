extends FSM_PlayerState

func handle_input(_event: InputEvent) -> void:
	player.set_input_vec()

func physics_update(delta: float) -> void:
	player.idle_skid()
	player.input_to_horizontal_air_movement(delta)
	player.horizontal_movement(delta)

	if (!player.is_on_floor()):
		player.velocity.y -= player.gravity * delta
	else:
		player.velocity.y = 0.0

	player.move_and_slide()

	if (player.inputVec != Vector2.ZERO):
		finished.emit(RUNNING)
	
	if (Input.is_action_just_pressed("ui_accept")):
		finished.emit(JUMPING)