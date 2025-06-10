extends CharacterBody2D

	
@export var speed : float = 100.0
@export var jump_velocity : float = -400.0

@onready var animation_player : AnimationPlayer = $AnimationPlayer

const BULLET = preload("res://Scenes/MagicBall.tscn")

var shoot_marker : Marker2D

func _ready() -> void:
	shoot_marker = $Marker2D
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	var sprite : Sprite2D = $Sprite2D as Sprite2D
	if velocity.x < 0:
		sprite.flip_h = true
	if velocity.x > 0:
		sprite.flip_h = false

	
	if velocity.y < 0:
		animation_player.play("Jump")
	elif not is_on_floor():
		animation_player.play("Fall")
	elif is_on_floor() and velocity.x:
		animation_player.play("Walk")
	else :
		animation_player.play("Idle")

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

		
	
