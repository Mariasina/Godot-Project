extends Node2D

const BULLET = preload("res://Scenes/MagicBall.tscn")

var shoot_marker : Marker2D
var staff_pivot : Node2D

func _ready() -> void:
	shoot_marker = $Cajado_Pivot/Marker2D
	staff_pivot = $Cajado_Pivot

func _physics_process(delta: float) -> void:
	staff_pivot.look_at(get_global_mouse_position())
	fire_bullet()

func fire_bullet():
	if Input.is_action_just_pressed("fire"):
		var bullet_instance = BULLET.instantiate()
		bullet_instance.global_position = shoot_marker.global_position
		bullet_instance.rotation = shoot_marker.global_rotation
		bullet_instance.direction = (get_global_mouse_position() - shoot_marker.global_position).normalized()
		get_tree().root.add_child(bullet_instance)
