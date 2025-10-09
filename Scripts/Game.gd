class_name Game

extends Node

# Game stats
static var is_game_over = false
static var survival_time : float = 0.0
static var enemies_killed_count : int = 0
static var game_gems : int = 0
# Start Coin
static var game_coin : float = 0
static var game_health : float = 10
static var game_radius : float = 1.0
static var game_cadence : float = 5.0
static var game_damage : float = 5.

# Base Shop Prices

static var game_damage_price : int = 7
static var game_health_price : int = 8
static var game_radius_price : int = 9
static var game_cadence_price : int = 10

static var game_damage_buy : float = 0.7
static var game_health_buy : float = 2.0
static var game_radius_buy : float = 0.4
static var game_cadence_buy : float = 0.3

static var price_multiplier : float = 1.2

static func _game_over():
	if (is_game_over):
		game_gems = (survival_time + enemies_killed_count)/(survival_time/enemies_killed_count)
		Global.ressources_gems += game_gems

func _ready() -> void:
	Global.load_progression()
	game_coin = game_coin + Global.start_coin
	game_health = game_health + Global.abilities_health
	game_radius = game_radius + Global.abilities_radius
	game_cadence = game_cadence - Global.abilities_cadence
	game_damage = game_damage + Global.abilities_attack
	print(str(game_damage) + "+" + str(Global.abilities_attack) + "=" + str(game_damage))
