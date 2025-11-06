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
static var is_game_over : bool = false
static var survival_time : float = 0.0
static var killed_enemy : int = 0
static var sapphire : int = 0
static var current_wave : int = 0

# Start Coin
static var game_damage : float = 5.0
static var game_health : float = 26.0
static var game_current_health : float = game_health
static var game_radius : float = 1.0
static var game_cadence : float = 5.0
static var game_coin : int = 0
static var game_bullet : int = 1
static var game_regeneration : float = 3.0


func _add_coins(amount : int): 
	game_coin += amount

func _reset_data():
	
	is_game_over = false
	survival_time = 0.0
	killed_enemy = 0
	sapphire = 0
	current_wave = 0
	
	
	game_coin = 0
	game_health = 12
	game_radius = 1.8
	game_cadence = 2.0
	game_damage = 2
	game_bullet = 1
	game_regeneration = 3.0
	
	game_damage = game_damage + Global.bonus_damage
	game_health = game_health + Global.bonus_health
	game_current_health = game_health
	game_coin = game_coin + Global.bonus_coin
	game_radius = game_radius + Global.bonus_radius
	game_cadence = game_cadence - Global.bonus_cadence
	game_bullet = game_bullet + Global.bonus_bullet
	game_regeneration = game_regeneration - Global.bonus_regeneration


func _ready() -> void:
	Global.load_progression()
	GameSignal.connect("s_game_over", Callable(self, "_on_game_over"))
	GameSignal.connect("s_wave_completed", Callable(self, "_on_wave_completed"))
	_reset_data()
	
func _on_wave_completed(reward):
	_add_coins(reward)


func _on_game_over(reason) -> void:
	if is_game_over:
		sapphire = (int(survival_time) / 10) + ((killed_enemy + (current_wave + 1)) / 2)
		if Game.current_wave >= Global.score_wave:
			Global.score_wave = Game.current_wave
		if Global.bonus_sapphire > 0:
			sapphire *= (1 + (Global.bonus_sapphire / 100)) 
			floor(sapphire)
		print("Saphire Game : " + str(Game.sapphire))
		Global.sapphire += sapphire
		Global.save_progression()
	else:
		print("No game over")
