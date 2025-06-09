extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const BULLET = preload("res://Scenes/MagicBall.tscn")

var shoot_marker : Marker2D

func _ready() -> void:
	shoot_marker = $Marker2D
	
	
func _physics_process(delta: float) -> void:
	print(shoot_marker.position)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	bullet_follow_mouse()
	fire_bullet()
	move_and_slide()
	
	
func bullet_follow_mouse():
	shoot_marker.look_at(get_global_mouse_position())

func fire_bullet():
	if Input.is_action_just_pressed("fire"):
		var bullet_instance = BULLET.instantiate()
		bullet_instance.global_position = shoot_marker.global_position
		bullet_instance.rotation = shoot_marker.rotation
		bullet_instance.direction = shoot_marker.transform.x

		get_tree().root.add_child(bullet_instance)

		
	
