extends Node


var progression_path := "user://progression.cfg"

var sapphire : int = 0
var bonus_damage : float = 0.0
var bonus_radius : float = 0.0
var bonus_health : int = 0.0
var bonus_cadence : float = 0.0
var bonus_coin : int = 100
var bonus_bullet : int = 0
var bonus_regeneration : float = 0.0
var bonus_ruse : float = 0.0
var bonus_sapphire : int = 0
var bonus_sapphire_wave : int = 0
var bonus_critical : float = 0.0
var bonus_health_point : int = 0

var score_wave : int = 0

var gameplay_time : int = 0

@onready var gameplay_times_array : Array[float] = [
	1.0,
	1.5,
	2.5,
	3.5
]


var bonus_damage_level : int = 0
var bonus_health_level : int = 0
var bonus_radius_level : int = 0
var bonus_cadence_level : int = 0
var bonus_coin_level : int = 0
var bonus_bullet_level : int = 0
var bonus_regeneration_level : int = 0
var bonus_ruse_level : int = 0
var bonus_sapphire_level : int = 0
var bonus_sapphire_wave_level : int = 0
var bonus_critical_level : int = 0
var bonus_health_point_level : int = 0


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
		bonus_ruse = config.get_value("bonus", "ruse", 0)
		bonus_sapphire = config.get_value("bonus", "sapphire", 0)
		bonus_sapphire_wave = config.get_value("bonus", "sapphire_wave", 0)
		bonus_critical = config.get_value("bonus", "critical", 0.0)
		bonus_health_point = config.get_value("bonus", "health_point", 0.0)
		
		sapphire   = config.get_value("shop", "sapphire", 0)
		bonus_damage_level = config.get_value("shop", "damage_level", 0)
		bonus_health_level = config.get_value("shop", "health_level", 0)
		bonus_radius_level = config.get_value("shop", "radius_level", 0)
		bonus_cadence_level = config.get_value("shop", "cadence_level", 0)
		bonus_coin_level = config.get_value("shop", "coin_level", 0)
		bonus_bullet_level = config.get_value("shop", "bullet_level", 0)
		bonus_regeneration_level = config.get_value("shop", "regeneration_level", 0)
		bonus_ruse_level = config.get_value("shop" ,"ruse_level", 0)
		bonus_sapphire_level = config.get_value("shop", "sapphire_level", 0)
		bonus_sapphire_wave_level = config.get_value("shop", "sapphire_wave_level", 0)
		bonus_critical_level = config.get_value("shop", "critical_level", 0)
		bonus_health_point_level = config.get_value("shop", "health_point_level", 0)
		
		# Score
		score_wave = config.get_value("score", "wave", 0)
		
		gameplay_time = config.get_value("gameplay", "time", 1.0)

func save_progression():
	var config = ConfigFile.new()
	config.set_value("bonus", "damage", bonus_damage)
	config.set_value("bonus", "health", bonus_health)
	config.set_value("bonus", "radius", bonus_radius)
	config.set_value("bonus", "cadence", bonus_cadence)
	config.set_value("bonus", "coin", bonus_coin)
	config.set_value("bonus", "bullet", bonus_bullet)
	config.set_value("bonus", "regeneration", bonus_regeneration)
	config.set_value("bonus", "ruse", bonus_ruse)
	config.set_value("bonus", "sapphire", bonus_sapphire)
	config.set_value("bonus", "sapphire_wave", bonus_sapphire_wave)
	config.set_value("bonus", "critical", bonus_critical)
	config.set_value("bonus", "health_point", bonus_health_point)
	
	
	config.set_value("shop", "sapphire", sapphire)
	config.set_value("shop", "damage_level", bonus_damage_level)
	config.set_value("shop", "radius_level", bonus_radius_level)
	config.set_value("shop", "health_level", bonus_health_level)
	config.set_value("shop", "cadence_level", bonus_cadence_level)
	config.set_value("shop", "coin_level", bonus_coin_level)
	config.set_value("shop", "bullet_level", bonus_bullet_level)
	config.set_value("shop", "regeneration_level", bonus_regeneration_level)
	config.set_value("shop" ,"ruse_level", bonus_ruse_level)
	config.set_value("shop", "sapphire_level", bonus_sapphire_level)
	config.set_value("shop", "sapphire_wave_level", bonus_sapphire_wave_level)
	config.set_value("shop", "critical_level", bonus_critical_level)
	config.set_value("shop", "health_point_level", bonus_health_point_level)
	
	
	config.set_value("score", "wave", score_wave)

	
	config.set_value("gameplay", "time", gameplay_time)
	
	config.save(progression_path)
