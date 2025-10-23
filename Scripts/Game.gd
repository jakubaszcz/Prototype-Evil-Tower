class_name Game

extends Node

signal game_over(reason: int)

enum GameOverReason {
	PLAYER_DEAD,
	ALL_WAVES_COMPLETED,
	TIME_LIMIT,
	MANUAL_EXIT
}

static var speed_multiplier : float = 1.0

# Game stats
static var is_game_over = false
static var survival_time : float = 0.0
static var enemies_killed_count : int = 0
static var game_gems : int = 0
static var current_wave : int = 0

# Start Coin
static var game_coin : int = 0
static var game_health : float = 22
static var game_current_health : float = 0
static var game_radius : float = 1.0
static var game_cadence : float = 5.0
static var game_damage : float = 5.0
static var game_bonus_bullet : int = 1
static var bonus_regeneration : float = 3.0

static func _game_over(reason: GameOverReason):
	if is_game_over:
		Game.game_gems = (int(survival_time) / 10) + ((enemies_killed_count + (current_wave + 1)) / 2)
		print("Survival Time: " + str(int(survival_time)))
		print("Enemi Killed: " + str(enemies_killed_count))
		print("Current Wave: " + str(current_wave))
		if reason == GameOverReason.ALL_WAVES_COMPLETED:
			Game.game_gems *= 1.25
		Global.sapphire += game_gems
		Global.save_progression()


func _add_coins(amount : int): 
	game_coin += amount

func _reset_data():
	is_game_over = false
	survival_time = 0.0
	enemies_killed_count = 0
	game_gems = 0
	current_wave = 0
	
	
	game_coin = 0
	game_health = 22
	game_radius = 1.2
	game_cadence = 3.5
	game_damage = 5.0
	game_bonus_bullet = 1
	bonus_regeneration = 5.0
	
	game_coin = game_coin + Global.bonus_coin
	game_health = game_health + Global.bonus_health
	game_current_health = game_health
	game_radius = game_radius + Global.bonus_radius
	game_cadence = game_cadence - Global.bonus_cadence
	game_damage = game_damage + Global.abilities_attack
	game_bonus_bullet = game_bonus_bullet + Global.bonus_bullet
	bonus_regeneration = bonus_regeneration - Global.bonus_regeneration

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
		_game_over(reason)
		return
	is_game_over = true
