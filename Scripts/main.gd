extends Node2D

@onready var score_label = $Player/Camera2D/Score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_label.text = str(Global.score) + "/" + str(Global.max_score)
