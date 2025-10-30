extends Node2D

signal wave_reward(reward)

@export var wave_file_path: String
@export var time_between_waves: float = 2.0           # ⏳ temps entre les vagues
@export var spawn_cadence: float = 0.5                # ⏱ délai entre chaque ennemi
@export var player: CharacterBody2D
@export var enemies: Array[PackedScene]

var enemy_map := {
	"basic": 0
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

# ------------------------------------------------
#  Génération d'une vague
# ------------------------------------------------
func generate_wave(wave_number:int) -> Array[Enemy]:
	rng.seed = int(global_seed + wave_number)
	
	var min = 1
	var max = 5
	
	if wave_number % 5 == 0:
		min += 1
	if wave_number % 10 == 0:
		max += 3
	
	var enemy_count = rng.randi_range(min, max)
	var wave_data : Array[Enemy] = []
	
	for i in range(enemy_count):
		var types_keys = enemy_map.keys()
		var enemy_type = types_keys[rng.randi_range(0, types_keys.size() - 1)]
		
		var enemy_scene_index = enemy_map[enemy_type]
		var enemy_scene = enemies[enemy_scene_index]
		var enemy = enemy_scene.instantiate() as Enemy
		
		var scale := 1.0 + (float(wave_number) / 10.0) * 0.1
		var attack_variation := rng.randf_range(0.8, 1.2)
		var health_variation := rng.randf_range(0.8, 1.2)
		var reward_variation := rng.randf_range(1.2, 1.7)
		
		enemy._set_attack(enemy._get_attack() * scale * attack_variation)
		enemy._set_health(enemy._get_health() * scale * health_variation)
		enemy._set_reward(enemy._get_reward() * scale * reward_variation)
		
		wave_data.append(enemy)
	
	return wave_data

# ------------------------------------------------
#  Initialisation
# ------------------------------------------------
func _ready() -> void:
	reset()
	Game.current_wave = 0
	if not is_wave_running:
		create_wave()

func reset() -> void:
	is_wave_running = false
	wave_in_progress = false
	enemies_alive = 0

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
		wave_timer.start(time_between_waves)
		await wave_timer.timeout
		is_wave_running = false
		create_wave()

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
