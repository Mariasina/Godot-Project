extends Node2D

@onready var particles = $CPUParticles2D
@onready var explosion_sound: AudioStreamPlayer = $Explosion_Sound
func _ready():
	particles.emitting = true
	explosion_sound.play()
	await get_tree().create_timer(1.0).timeout
	queue_free()
