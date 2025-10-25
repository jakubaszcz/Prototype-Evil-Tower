extends Node2D

signal wave_reward(reward)

@export var wave_file_path: String
@export var time_between_waves: float = 0.5
@export var player: CharacterBody2D

var waves: Array = []
var enemies_alive: int = 0
var current_reward: int = 0
var current_spawn_cadence: float = 0.0
var waves_completed: bool = false
var wave_in_progress: bool = false
var should_stop: bool = false

@onready var wave_timer: Timer = $WaveTimer


func _ready() -> void:

	Game.current_wave = 0

	wave_timer.stop()
	if wave_timer.timeout.is_connected(_on_wave_timer_timeout):
		wave_timer.timeout.disconnect(_on_wave_timer_timeout)
	wave_timer.timeout.connect(_on_wave_timer_timeout)

	waves = _load_waves_from_file(wave_file_path)

	if Game.current_wave <= 0:
		Game.current_wave = 0
		_start_next_wave()


func _load_waves_from_file(path: String) -> Array:
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		var data = JSON.parse_string(text)
		if typeof(data) == TYPE_ARRAY:
			return data
	return []


func _on_wave_timer_timeout() -> void:
	if should_stop or wave_in_progress or waves_completed:
		return
	_start_next_wave()


func _start_next_wave() -> void:
	if wave_in_progress or waves_completed or should_stop:
		return

	wave_timer.stop()
	enemies_alive = 0

	if Game.current_wave >= waves.size():
		_finish_game()
		return

	wave_in_progress = true

	var wave_data = waves[Game.current_wave]
	current_reward = wave_data.get("reward", 0)
	current_spawn_cadence = wave_data.get("spawn_cadence", 0.2)

	await spawn_wave_async(wave_data)

	await wait_until_wave_cleared()

	if not should_stop:
		_on_wave_cleared()


func spawn_wave_async(wave_data: Dictionary) -> void:
	for enemy_info in wave_data["enemies"]:
		if should_stop:
			return
		var scene = load(enemy_info["type"])
		for i in range(enemy_info["count"]):
			if should_stop:
				return
			_spawn_enemy(scene)
			await get_tree().create_timer(current_spawn_cadence).timeout


func _spawn_enemy(scene: PackedScene) -> void:
	var enemy = scene.instantiate()
	enemy._set_target(player)
	enemy.position = get_spawn_position()
	call_deferred("add_child", enemy)

	if enemy.has_signal("enemy_died"):
		enemy.connect("enemy_died", Callable(self, "_on_enemy_died").bind(enemy))

	enemies_alive += 1


func _on_enemy_died(enemy) -> void:
	if enemy and enemy.has_signal("enemy_died") and enemy.is_connected("enemy_died", Callable(self, "_on_enemy_died").bind(enemy)):
		enemy.disconnect("enemy_died", Callable(self, "_on_enemy_died").bind(enemy))

	if waves_completed or should_stop:
		return

	enemies_alive = max(enemies_alive - 1, 0)


func wait_until_wave_cleared() -> void:
	while enemies_alive > 0 and not should_stop and is_inside_tree():
		await get_tree().process_frame

func _on_wave_cleared() -> void:
	if not is_inside_tree():
		return
		
	wave_in_progress = false
	emit_signal("wave_reward", current_reward)
	Game.current_wave += 1
	if Game.current_wave < waves.size():
		wave_timer.start(time_between_waves)
	else:
		_finish_game()


func _finish_game() -> void:
	if waves_completed:
		return
	waves_completed = true
	should_stop = true
	GameSignal.emit_signal("s_game_over", "waves_completed")
	_cleanup_enemies()


func _cleanup_enemies() -> void:
	for child in get_children():
		if child.has_signal("enemy_died") and child.is_connected("enemy_died", Callable(self, "_on_enemy_died").bind(child)):
			child.disconnect("enemy_died", Callable(self, "_on_enemy_died").bind(child))
		if child.has_method("queue_free"):
			child.queue_free()


func get_spawn_position() -> Vector2:
	var rect = $".."
	#var rect = $".."
	var margin = 5
	var side = randi() % 4

	match side:
		0: return Vector2(randf_range(0, rect.size.x), -margin) # Top
		1: return Vector2(randf_range(0, rect.size.x), rect.size.y + margin) # Bottom
		2: return Vector2(-margin, randf_range(0, rect.size.y)) # Left
		3: return Vector2(rect.size.x + margin, randf_range(0, rect.size.y)) # Right

	return Vector2.ZERO
