extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

const MOUSE_SENSIBILITY = 0.003
var _gun_pitch: float = 0.0
const VERTICAL_LOOK_MAX_ANGLE = 45

@onready var bullet = preload("res://player_bullet/player_bullet.tscn")
@onready var muzzle = $"Body/AssaultRifle2_1/Muzzle"

@onready var gun = $"Body/AssaultRifle2_1"

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSIBILITY)
		_gun_pitch -= event.relative.y * MOUSE_SENSIBILITY
		_gun_pitch = clamp(_gun_pitch, deg_to_rad(-VERTICAL_LOOK_MAX_ANGLE), deg_to_rad(VERTICAL_LOOK_MAX_ANGLE))
		gun.rotation.z = _gun_pitch
	if event is InputEventMouseButton: # testa se clicou com o mouse
		if event.button_index == 1: # testa se o botão ESQUERDO
			var b = bullet.instantiate()
			get_parent().add_child(b)
			b.global_position = muzzle.global_position
			b.global_rotation = muzzle.global_rotation

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	

	move_and_slide()
