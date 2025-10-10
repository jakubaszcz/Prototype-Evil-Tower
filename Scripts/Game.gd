class_name Game

extends Node

# Game stats
static var is_game_over = false
static var survival_time : float = 0.0
static var enemies_killed_count : int = 0
static var game_gems : int = 0
static var current_wave : int = -1

# Start Coin
static var game_coin : int = 0
static var game_health : float = 10
static var game_radius : float = 1.0
static var game_cadence : float = 5.0
static var game_damage : float = 5.0

static func _game_over():
	if is_game_over:
		var efficiency = enemies_killed_count / max(survival_time, 1.0)   # kills per second
		var wave_bonus = (current_wave + 1) * 2.5                         # scaling plus visible
		var base_reward = enemies_killed_count * 1.5                      # core reward
		var time_bonus = efficiency * 15                                  # speed reward
		var total_reward = int(round((base_reward + time_bonus) * wave_bonus))
		
		Game.game_gems += total_reward
		print("🏆 Final reward:", total_reward, "gems")


		Global.ressources_gems += game_gems

func _add_coins(amount : int): 
	game_coin += amount

func _reset_data():
	is_game_over = false
	survival_time = 0.0
	enemies_killed_count = 0
	game_gems = 0
	current_wave = -1
	
	game_coin = 0
	game_health = 10
	game_radius = 1.0
	game_cadence = 5.0
	game_damage = 5.0
	
	game_coin = game_coin + Global.bonus_coin
	game_health = game_health + Global.abilities_health
	game_radius = game_radius + Global.abilities_radius
	game_cadence = game_cadence - Global.abilities_cadence
	game_damage = game_damage + Global.abilities_attack

func _ready() -> void:
	Global.load_progression()
	var wave_manager = get_node("/root/Game/Components/Spawn/WaveManager")
	wave_manager.connect("wave_reward", Callable(self, "_on_wave_reward"))
	_reset_data()
	
func _on_wave_reward(reward):
	_add_coins(reward)
