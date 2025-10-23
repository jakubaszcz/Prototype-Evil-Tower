extends Node

func _physics_process(delta: float) -> void:
	if not Game.is_game_over:
		Game.survival_time += delta
		
