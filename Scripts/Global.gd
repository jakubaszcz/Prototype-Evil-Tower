extends Node


var progression_path := "user://progression.cfg"

var ressources_gems : int = 0
var abilities_attack : int = 0.0
var abilities_radius : float = 0.0
var abilities_health : int = 0.0
var abilities_cadence : float = 0.0
var shoot_per_shot : int = 0
var regeneration : float = 0.0

var bonus_coin : int = 0

var bonus_coin_price : int = 19
var bonus_ammo_price : int = 123

var bonus_coin_reward : int = 3
var bonus_ammo_reward : int = 1

var bonus_coin_multiplier = 1.7

var abilities_attack_price : int = 12
var abilities_radius_price : int = 13
var abilities_health_price : int = 15
var abilities_cadence_price : int = 17

var abilities_attack_price_multiplier : float = 2.2
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
var shoot_per_shot_shop_level : int = 1
var regeneration_level : int = 1

var bonus_coin_shop_level : int = 1


func load_progression():
	var config = ConfigFile.new()
	var error = config.load(progression_path)
	if error == OK:
		ressources_gems   = config.get_value("progress", "gems", 0)
		abilities_attack  = config.get_value("progress", "attack", 0.0)
		abilities_radius  = config.get_value("progress", "radius", 0.0)
		abilities_health  = config.get_value("progress", "health", 0.0)
		abilities_cadence = config.get_value("progress", "cadence", 0.0)
		bonus_coin        = config.get_value("progress", "coin", 0)
		shoot_per_shot = config.get_value("progress", "shoot_per_shot", 0)
		regeneration = config.get_value("progress", "regeneration", 0)
		abilities_attack_shop_level = config.get_value("shop", "attack_shop_level", 1)
		abilities_radius_shop_level = config.get_value("shop", "radius_shop_level", 1)
		abilities_health_shop_level = config.get_value("shop", "health_shop_level", 1)
		abilities_cadence_shop_level = config.get_value("shop", "cadence_shop_level", 1)
		shoot_per_shot_shop_level = config.get_value("shop", "shoot_per_shot_level", 1)
		bonus_coin_shop_level = config.get_value("shop", "coin_shop_level", 1)
		regeneration_level = config.get_value("shop", "regeneration_level", 1)
	print("After Load " + str(abilities_attack))

func save_progression():
	var config = ConfigFile.new()
	config.set_value("progress", "gems", ressources_gems)
	config.set_value("progress", "attack", abilities_attack)
	config.set_value("progress", "radius", abilities_radius)
	config.set_value("progress", "health", abilities_health)
	config.set_value("progress", "cadence", abilities_cadence)
	config.set_value("progress", "coin", bonus_coin)
	config.set_value("progress", "shoot_per_shot", shoot_per_shot)
	config.set_value("progress", "regeneration", regeneration)
	config.set_value("shop", "attack_shop_level", abilities_attack_shop_level)
	config.set_value("shop", "radius_shop_level", abilities_radius_shop_level)
	config.set_value("shop", "health_shop_level", abilities_health_shop_level)
	config.set_value("shop", "cadence_shop_level", abilities_cadence_shop_level)
	config.set_value("shop", "coin_shop_level", bonus_coin_shop_level)
	config.set_value("shop", "shoot_per_shot_level", shoot_per_shot_shop_level)
	config.set_value("shop", "regeneration_level", regeneration_level)
	config.save(progression_path)
