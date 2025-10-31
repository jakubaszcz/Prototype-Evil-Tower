extends Node2D

signal wave_reward(reward)

@export var wave_file_path: String
@export var time_between_waves: float = 2.0           # ⏳ temps entre les vagues
@export var spawn_cadence: float = 0.5                # ⏱ délai entre chaque ennemi
@export var player: CharacterBody2D
@export var enemies: Array[PackedScene]
@export var mini_bosses : Array[PackedScene]
@export var bosses : Array[PackedScene]

var enemy_map := {
	"basic": 0,
	"fool": 1,
	"nick": 2,
	"ninja": 3,
	"lockhlass": 4,
}

var mini_boss_map := {
	"golem": 0
}

var boss_map := {
	"scarlet": 0
}

var waves: Array = []
var enemies_alive: int = 0
var current_reward: int = 0
var current_spawn_cadence: float = 0.0
var waves_completed: bool = false
var wave_in_progress: bool = false
var should_stop: bool = false

@onready var wave_timer: Timer = $WaveTimer
var is_wave_running : bool = false
var enemy_count : int = 0

var global_seed: int = 2875230357186581542
var rng := RandomNumberGenerator.new()

var min = 2
var max = 5

var five_wave_count = 0

var enemy_range = 1

var reward = 7

func generate_wave(wave_number:int) -> Array[Enemy]:
	rng.seed = int(global_seed + wave_number)
	
	if wave_number % 5 == 0:
		five_wave_count += 1
		min += 1
	if wave_number % 10 == 0:
		max += 3
	
	enemy_range = five_wave_count
	if enemy_range >= enemy_map.size() - 1: enemy_range = enemy_map.size() - 1
	
	var enemy_count = rng.randi_range(min, max)
	var wave_data : Array[Enemy] = []
	
	for i in range(enemy_count):
		var types_keys = enemy_map.keys()
		var enemy_type = types_keys[rng.randi_range(0, enemy_range)]
		
		var enemy_scene_index = enemy_map[enemy_type]
		var enemy_scene = enemies[enemy_scene_index]
		var enemy = enemy_scene.instantiate() as Enemy
		
		var base_growth := 1.015 + (float(wave_number) / 2000.0)
		var scale := pow(base_growth, wave_number * 0.9)

# 🎲 Variations aléatoires
		var attack_variation := rng.randf_range(0.9, 1.1)
		var health_variation := rng.randf_range(0.9, 1.1)
		var reward_variation := rng.randf_range(1.1, 1.5)

		enemy._set_attack(enemy._get_attack() * scale * attack_variation)
		enemy._set_health(enemy._get_health() * scale * health_variation)
		enemy._set_reward(enemy._get_reward() * pow(scale, 0.6) * reward_variation)
		
		wave_data.append(enemy)

	if wave_number % 5 == 0:
		var mbtypes_keys = mini_boss_map.keys()
		var mini_boss_type = mbtypes_keys[rng.randi_range(0, mbtypes_keys.size() - 1)]
		
		var mini_boss_scene_index = mini_boss_map[mini_boss_type]
		var mini_boss_scene = mini_bosses[mini_boss_scene_index]
		
		var mini_boss = mini_boss_scene.instantiate() as Enemy
		var mb_scale := 1.0 + (float(wave_number) / 6.0) * 0.1
		var mb_attack_variation := rng.randf_range(0.8, 1.2)
		var mb_health_variation := rng.randf_range(0.8, 1.2)
		var mb_reward_variation := rng.randf_range(1.2, 1.7)
		
		mini_boss._set_attack(mini_boss._get_attack() * mb_scale * mb_attack_variation)
		mini_boss._set_health(mini_boss._get_health() * mb_scale * mb_health_variation)
		mini_boss._set_reward(mini_boss._get_reward() * mb_scale * mb_reward_variation)
	
		wave_data.append(mini_boss)	
	
	if wave_number % 10 == 0:
		var btypes_keys = boss_map.keys()
		var boss_type = btypes_keys[rng.randi_range(0, btypes_keys.size() - 1)]
		
		var boss_scene_index = boss_map[boss_type]
		var boss_scene = bosses[boss_scene_index]
		
		var boss = boss_scene.instantiate() as Enemy
		var b_scale := 1.0 + (float(wave_number) / 6.0) * 0.1
		var b_attack_variation := rng.randf_range(0.8, 1.2)
		var b_health_variation := rng.randf_range(0.8, 1.2)
		var b_reward_variation := rng.randf_range(1.2, 1.7)
		
		boss._set_attack(boss._get_attack() * b_scale * b_attack_variation)
		boss._set_health(boss._get_health() * b_scale * b_health_variation)
		boss._set_reward(boss._get_reward() * b_scale * b_reward_variation)
	
		wave_data.append(boss)
	
	
	return wave_data

func _ready() -> void:
	reset()
	Game.current_wave = 0
	if not is_wave_running:
		create_wave()

func reset() -> void:
	is_wave_running = false
	wave_in_progress = false
	enemies_alive = 0
	enemy_range = 1
	reward = 7
	min = 2
	max = 5

func create_wave():
	if is_wave_running: return
	
	is_wave_running = true
	Game.current_wave += 1
	print("🌀 Create wave number:", Game.current_wave)
	
	var wave : Array[Enemy] = generate_wave(Game.current_wave)
	await deploy_enemies(wave)

func deploy_enemies(data: Array[Enemy]):
	for enemy in data:
		create_enemy(enemy)
		await get_tree().create_timer(spawn_cadence).timeout

func create_enemy(enemy: Enemy):
	enemy._set_target(player)
	enemy.position = get_spawn_position()
	call_deferred("add_child", enemy)
	
	if enemy.has_signal("enemy_died"):
		enemy.connect("enemy_died", Callable(self, "_on_enemy_died").bind(enemy))

	enemies_alive += 1

func _on_enemy_died(enemy: Enemy) -> void:
	if enemy and enemy.has_signal("enemy_died") and enemy.is_connected("enemy_died", Callable(self, "_on_enemy_died").bind(enemy)):
		enemy.disconnect("enemy_died", Callable(self, "_on_enemy_died").bind(enemy))

	enemies_alive = max(enemies_alive - 1, 0)

	if enemies_alive == 0:
		print("✅ Wave", Game.current_wave, "cleared! Waiting", time_between_waves, "seconds...")
		GameSignal.emit_signal("s_wave_completed", calculate_reward())
		wave_timer.start(time_between_waves)
		await wave_timer.timeout
		is_wave_running = false
		create_wave()

func calculate_reward() -> int:
	return reward * (1.15 * Game.current_wave)

func get_spawn_position() -> Vector2:
	var rect = get_viewport_rect()
	var margin = 4 + (Game.game_radius * 1.25)
	var side = randi() % 4

	match side:
		0: return Vector2(randf_range(0, rect.size.x), -margin) # Top
		1: return Vector2(randf_range(0, rect.size.x), rect.size.y + margin) # Bottom
		2: return Vector2(-margin, randf_range(0, rect.size.y)) # Left
		3: return Vector2(rect.size.x + margin, randf_range(0, rect.size.y)) # Right

	return Vector2.ZERO
