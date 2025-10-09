extends Node


var progression_path := "user://progression.cfg"

var ressources_gems : int = 0
var abilities_attack : int = 0.0
var abilities_radius : float = 0.0
var abilities_health : int = 0.0
var abilities_cadence : float = 0.0

var abilities_attack_price : int = 12
var abilities_radius_price : int = 13
var abilities_health_price : int = 15
var abilities_cadence_price : int = 17

var abilities_attack_price_multiplier : float = 1.2
var abilities_radius_price_multiplier : float = 1.4
var abilities_health_price_multiplier : float = 1.6
var abilities_cadence_price_multiplier : float = 1.8

var abilities_attack_reward : int = 2
var abilities_radius_reward : float = 0.2
var abilities_health_reward : int = 3
var abilities_cadence_reward : float = 0.3

var abilities_attack_shop_level : int = 1
var abilities_radius_shop_level : int = 1
var abilities_health_shop_level : int = 1
var abilities_cadence_shop_level : int = 1

var start_coin : int = 0

func load_progression():
	var config = ConfigFile.new()
	var error = config.load(progression_path)
	if error == OK:
		ressources_gems   = config.get_value("progress", "gems", 0)
		abilities_attack  = config.get_value("progress", "attack", 0.0)
		abilities_radius  = config.get_value("progress", "radius", 0.0)
		abilities_health  = config.get_value("progress", "health", 0.0)
		abilities_cadence = config.get_value("progress", "cadence", 0.0)
		start_coin        = config.get_value("progress", "coin", 0)
		abilities_attack_shop_level = config.get_value("shop", "attack_shop_level", 1)
		abilities_radius_shop_level = config.get_value("shop", "radius_shop_level", 1)
		abilities_health_shop_level = config.get_value("shop", "health_shop_level", 1)
		abilities_cadence_shop_level = config.get_value("shop", "cadence_shop_level", 1)
	print("After Load " + str(abilities_attack))

func save_progression():
	var config = ConfigFile.new()
	config.set_value("progress", "gems", ressources_gems)
	config.set_value("progress", "attack", abilities_attack)
	config.set_value("progress", "radius", abilities_radius)
	config.set_value("progress", "health", abilities_health)
	config.set_value("progress", "cadence", abilities_cadence)
	config.set_value("progress", "coin", start_coin)
	config.set_value("shop", "attack_shop_level", abilities_attack_shop_level)
	config.set_value("shop", "radius_shop_level", abilities_radius_shop_level)
	config.set_value("shop", "health_shop_level", abilities_health_shop_level)
	config.set_value("shop", "cadence_shop_level", abilities_cadence_shop_level)
	config.save(progression_path)
