extends FSM_PlayerState

func enter(_prevState: String) -> void:
    player.velocity.y = player.jumpImpulse

func handle_input(_event: InputEvent) -> void:
    player.set_input_vec()

func physics_update(delta) -> void:
    player.velocity.y -= player.gravity * delta
    player.input_to_horizontal_air_movement(delta)
    player.horizontal_movement(delta)
    player.move_and_slide()
    
    if (player.is_on_floor()):
        finished.emit(IDLE)

    if (Input.is_action_just_pressed("ui_accept")):
        finished.emit(DOUBLE_JUMP)