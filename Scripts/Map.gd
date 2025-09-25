extends Node2D

@export var enemy_to_spawn : PackedScene
@export var player : CharacterBody2D

func _ready():
	pass

func _process(delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	var e = enemy_to_spawn.instantiate() # Create a new enemy
	e.player = player
	call_deferred("add_child", e) # Add the enemy to the scene
	e.position = get_spawn_position()

func get_spawn_position() -> Vector2:
	var rect = get_viewport_rect()
	var margin = 100
	var side = randi() % 4

	match side:
		0: # Up
			return Vector2(randf_range(0, rect.size.x), -margin)
		1: # Down
			return Vector2(randf_range(0, rect.size.x), rect.size.y + margin)
		2: # Right
			return Vector2(-margin, randf_range(0, rect.size.y))
		3: # Left
			return Vector2(rect.size.x + margin, randf_range(0, rect.size.y))
	return Vector2.ZERO
