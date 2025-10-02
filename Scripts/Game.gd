extends Node

# Start Coin
var game_coin : float = 0 + Global.start_coin
var game_health : float = 10 + Global.abilities_health
var game_radius : float = 10.0 + Global.abilities_radius
var game_cadence : float = 2.0 + Global.abilities_cadence
var game_damage : float = 10.0 + Global.abilities_attack

# Base Shop Prices

var game_damage_price : int = 7
var game_health_price : int = 8
var game_radius_price : int = 9
var game_cadence_price : int = 10

var game_damage_buy : float = 0.7
var game_health_buy : float = 2.0
var game_radius_buy : float = 0.4
var game_cadence_buy : float = 0.3

var multiplier : float = 1.2
