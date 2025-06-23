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
var rand
var rand2
var rand3
const BLUE = preload("res://Scenes/Coletavel_Azul.tscn")
const GREEN = preload("res://Scenes/Coletavel_Verde.tscn")
const RED = preload("res://Scenes/Coletavel_Vermelho.tscn")

func _ready() -> void:
	collision = $Area2D/CollisionShape2D

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
	generate_rands()
	if body.name == "TileMapLayer" or body.name == "TileMapLayer2":
		tilemap = body
		var tile_coord = tilemap.get_coords_for_body_rid(body_rid)
		
		if tilemap.get_cell_source_id(tile_coord) == 0 or tilemap.get_cell_source_id(tile_coord) == 2:
			collided = true
			var tile_world_pos = tilemap.map_to_local(tile_coord) + tilemap.position
			spawn_explosion(tile_world_pos)
			tilemap.erase_cell(tile_coord)
			
			if rand == 1:
				print("blue")
				instantiate_colectible(BLUE, tile_world_pos)
			if rand == 2:
				print("green")
				instantiate_colectible(GREEN, tile_world_pos)
			if rand == 3:
				print("red")
				instantiate_colectible(RED, tile_world_pos)
				
func instantiate_colectible(instance, tile_pos):
	var colectible : Node2D = instance.instantiate()
	colectible.global_position = tile_pos
	print(colectible.global_position)
	print(tile_pos)
	get_tree().root.add_child(colectible)
	
func generate_rands():
	var rng = RandomNumberGenerator.new()
	rand = rng.randi_range(1, 200)
	
	print(rand)
			
func spawn_explosion(pos: Vector2):
	if explosion_effect:
		var explosion_instance = explosion_effect.instantiate()
		explosion_instance.global_position = pos
		get_tree().get_current_scene().add_child(explosion_instance)
