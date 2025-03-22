extends FSM_PlayerState

var node_jumpParticle = preload("res://Scenes/Particle/Hit.tscn")

func enter(_prevState: String) -> void:
    player.velocity.y = player.jumpImpulse / 2
    var jumpParticle = node_jumpParticle.instantiate();
    jumpParticle.position = player.position
    jumpParticle.position.y -= 0.2
    add_child(jumpParticle)

func handle_input(_event: InputEvent) -> void:
    player.set_input_vec()

func physics_update(delta) -> void:
    player.velocity.y -= player.gravity * delta
    player.input_to_horizontal_air_movement(delta)
    player.move_and_slide()

    if (player.is_on_floor()):
        finished.emit(IDLE)