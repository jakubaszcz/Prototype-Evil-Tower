extends Node


var progression_path := "user://progression.cfg"

var sapphire : int = 0
var bonus_damage : int = 0.0
var bonus_radius : float = 0.0
var bonus_health : int = 0.0
var bonus_cadence : float = 0.0
var bonus_coin : int = 0
var bonus_bullet : int = 0
var bonus_regeneration : float = 0.0


var bonus_damage_level : int = 1
var bonus_health_level : int = 1
var bonus_radius_level : int = 1
var bonus_cadence_level : int = 1
var bonus_coin_level : int = 1
var bonus_bullet_level : int = 1
var bonus_regeneration_level : int = 1

func load_progression():
	var config = ConfigFile.new()
	var error = config.load(progression_path)
	if error == OK:
		bonus_damage  = config.get_value("bonus", "damage", 0.0)
		bonus_health  = config.get_value("bonus", "health", 0.0)
		bonus_radius  = config.get_value("bonus", "radius", 0.0)
		bonus_cadence = config.get_value("bonus", "cadence", 0.0)
		bonus_coin        = config.get_value("bonus", "coin", 0)
		bonus_bullet = config.get_value("bonus", "bullet", 0)
		bonus_regeneration = config.get_value("bonus", "regeneration", 0)
		sapphire   = config.get_value("shop", "sapphire", 0)
		bonus_damage_level = config.get_value("shop", "damage_level", 1)
		bonus_health_level = config.get_value("shop", "health_level", 1)
		bonus_radius_level = config.get_value("shop", "radius_level", 1)
		bonus_cadence_level = config.get_value("shop", "cadence_level", 1)
		bonus_coin_level = config.get_value("shop", "coin_level", 1)
		bonus_bullet_level = config.get_value("shop", "bullet_level", 1)
		bonus_regeneration_level = config.get_value("shop", "regeneration_level", 1)

func save_progression():
	var config = ConfigFile.new()
	config.set_value("bonus", "damage", bonus_damage)
	config.set_value("bonus", "health", bonus_health)
	config.set_value("bonus", "radius", bonus_radius)
	config.set_value("bonus", "cadence", bonus_cadence)
	config.set_value("bonus", "coin", bonus_coin)
	config.set_value("bonus", "bullet", bonus_bullet)
	config.set_value("bonus", "regeneration", bonus_regeneration)
	config.set_value("shop", "sapphire", sapphire)
	config.set_value("shop", "attack_level", bonus_damage_level)
	config.set_value("shop", "radius_level", bonus_radius_level)
	config.set_value("shop", "health_level", bonus_health_level)
	config.set_value("shop", "cadence_level", bonus_cadence_level)
	config.set_value("shop", "coin_level", bonus_coin_level)
	config.set_value("shop", "bullet_level", bonus_bullet_level)
	config.set_value("shop", "regeneration_level", bonus_regeneration_level)
	config.save(progression_path)
