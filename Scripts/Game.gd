class_name Game

extends Node

signal game_over(reason: int)

enum GameOverReason {
	PLAYER_DEAD,
	ALL_WAVES_COMPLETED,
	TIME_LIMIT,
	MANUAL_EXIT
}

# Game stats
static var is_game_over = false
static var survival_time : float = 0.0
static var enemies_killed_count : int = 0
static var game_gems : int = 0
static var current_wave : int = -1

# Start Coin
static var game_coin : int = 0
static var game_health : float = 14
static var game_radius : float = 1.0
static var game_cadence : float = 5.0
static var game_damage : float = 5.0

static func _game_over():
	if is_game_over:
		Game.game_gems = (survival_time / 10) + ((enemies_killed_count + current_wave) / 2)
		Global.ressources_gems += game_gems
		Global.save_progression()


func _add_coins(amount : int): 
	game_coin += amount

func _reset_data():
	is_game_over = false
	survival_time = 0.0
	enemies_killed_count = 0
	game_gems = 0
	current_wave = -1
	
	game_coin = 0
	game_health = 12
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
	game_over.connect(_game_over)
	var wave_manager = get_node("/root/Game/Components/Spawn/WaveManager")
	wave_manager.connect("wave_reward", Callable(self, "_on_wave_reward"))
	_reset_data()
	
func _on_wave_reward(reward):
	_add_coins(reward)


static func end_game(reason: GameOverReason) -> void:
	if is_game_over:
		return
	is_game_over = true
