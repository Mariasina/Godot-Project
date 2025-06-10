extends Node2D

const SPEED = 300
var direction = Vector2.RIGHT
var tilemap : TileMapLayer
var collision : CollisionShape2D
var collided = false
var cell
var tile_id

func _ready() -> void:
	
	collision = $Area2D/CollisionShape2D

func _physics_process(delta: float) -> void:
	if (!collided):
		position += direction.normalized() * SPEED * delta
	if (collided):
		queue_free()
	#if (collision != null and !collided):
		#collided = true 
		#if (collision.collider.name == "TileMapLayer"):
			#cell = tilemap.world_to_map(collision.position - collision.normal)
			#tile_id = tilemap.get_cellv(cell)
			#if tile_id == 0:
				#tilemap.erase_cell(cell) 
				#

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "TileMapLayer":
		tilemap = body
		var tile_coord = tilemap.get_coords_for_body_rid(body_rid)
		
		if (tilemap.get_cell_source_id(tile_coord) == 0):
			collided = true
			tilemap.erase_cell(tile_coord)
