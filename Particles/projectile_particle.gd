extends Node2D

@onready var particles = $CPUParticles2D

func _ready():
	particles.emitting = true
	await get_tree().create_timer(1.0).timeout
	queue_free()
