extends Node2D

@export var enemies_to_spawn: Array[PackedScene] = []
@export var player: CharacterBody2D

func _on_spawn_timer_timeout() -> void:
	if enemies_to_spawn.is_empty():
		return
		
	var enemy_scene: PackedScene = enemies_to_spawn.pick_random()
	var e = enemy_scene.instantiate()
	e._set_target(player)
	e.position = get_spawn_position()
	call_deferred("add_child", e)


func get_spawn_position() -> Vector2:
	var rect = get_viewport_rect()
	var margin = 5
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
