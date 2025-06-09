extends Node2D

const SPEED = 300
var direction = Vector2.RIGHT
var tilemap : TileMapLayer

func _ready() -> void:
	tilemap = get_tree().get_current_scene().find_child("TileMapLayer", true, false)

func _physics_process(delta: float) -> void:
	position += direction.normalized() * SPEED * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "TileMapLayer":
		var cell = tilemap.world_to_map(global_position)
		var tile_id = tilemap.get_cellv(cell)
		if tile_id == 0:
			tilemap.set_cellv(cell, -1) # -1 = apaga o tile
		queue_free() # destrói a magic ball
