class_name Player extends CharacterBody3D

@export var speed := 0.0
@export var maxSpeed := 150.0
@export var accel := 5
@export var gravity := 10.0
@export var jumpImpulse := 5.0
@export var airDrift := 5.0
@export var dustTimer := 15
@export var friction := 20.0
@export var airFriction := 6.0
var inputVec: Vector2 = Vector2.ZERO

func set_input_vec() -> void:
    inputVec.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    inputVec.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    print(velocity)

func input_to_horizontal_movement(delta: float) -> void:
    if (speed < maxSpeed):
        speed = clamp(speed + accel, 0, maxSpeed)
    var temp: Vector2 = Vector2(velocity.x, velocity.z)
    temp = temp.lerp(inputVec, delta * friction).normalized()
    velocity.x = temp.x
    velocity.z = temp.y

func input_to_horizontal_air_movement(delta: float) -> void:
    var temp: Vector2 = Vector2(velocity.x, velocity.z)
    temp = temp.lerp(inputVec, delta * airFriction).normalized()
    velocity.x = temp.x
    velocity.z = temp.y

func horizontal_movement(delta: float) -> void:
    velocity.x *= (delta * speed)
    velocity.z *= (delta * speed)

func idle_skid() -> void:
    if (speed > 0):
        speed = clamp(speed - accel, 0, maxSpeed)
