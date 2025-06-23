extends Node

var score = 0
var max_score = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if score == max_score:
		score = 0
		get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
