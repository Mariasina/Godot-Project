extends Node2D

@onready var pickup_sound: AudioStreamPlayer = $Pickup_Sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		pickup_sound.play()
		await get_tree().create_timer(0.2).timeout
		Global.score += 1
		print(Global.score)
		queue_free()
