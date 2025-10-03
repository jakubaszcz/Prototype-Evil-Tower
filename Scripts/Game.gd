extends Node

# Game stats
var is_game_over = false
var survival_time : float = 0.0
var enemies_killed_count : int = 0
var game_gems : int = 0
# Start Coin
var game_coin : float = 0 + Global.start_coin
var game_health : float = 10 + Global.abilities_health
var game_radius : float = 1.0 + Global.abilities_radius
var game_cadence : float = 5.0 - Global.abilities_cadence
var game_damage : float = 5.0 + Global.abilities_attack

# Base Shop Prices

var game_damage_price : int = 7
var game_health_price : int = 8
var game_radius_price : int = 9
var game_cadence_price : int = 10

var game_damage_buy : float = 0.7
var game_health_buy : float = 2.0
var game_radius_buy : float = 0.4
var game_cadence_buy : float = 0.3

var price_multiplier : float = 1.2

func _game_over():
	if (is_game_over):
		game_gems = (survival_time + enemies_killed_count)/(survival_time/enemies_killed_count)
		Global.ressources_gems += game_gems
		print("You won "+str(game_gems))
		print(str(survival_time))
	
