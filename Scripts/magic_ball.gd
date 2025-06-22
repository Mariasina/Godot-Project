extends Node2D
@export var explosion_effect : PackedScene = preload("res://Particles/ProjectileParticle.tscn")
@onready var animation_Projectile : AnimationPlayer = $AnimationPlayer

const SPEED = 200
var direction = Vector2.RIGHT
var tilemap : TileMapLayer
var collision : CollisionShape2D
var collided = false
var cell
var tile_id
var rand1
var rand2
var rand3

func _ready() -> void:
	collision = $Area2D/CollisionShape2D
	var rng = RandomNumberGenerator.new()
	rand1 = rng.randi_range(1, 100)
	rand2 = rng.randi_range(1, 100)
	rand3 = rng.randi_range(1, 100)

func _physics_process(delta: float) -> void:
	if (!collided):
		position += direction.normalized() * SPEED * delta
		animation_Projectile.play("Projectile_Animation")
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
		
		if tilemap.get_cell_source_id(tile_coord) == 0:
			collided = true
			var tile_world_pos = tilemap.map_to_local(tile_coord) + tilemap.position
			spawn_explosion(tile_world_pos)
			tilemap.erase_cell(tile_coord)
			
			if rand1 == 7:
				print(rand1)

			
func spawn_explosion(pos: Vector2):
	if explosion_effect:
		var explosion_instance = explosion_effect.instantiate()
		explosion_instance.global_position = pos
		get_tree().get_current_scene().add_child(explosion_instance)
