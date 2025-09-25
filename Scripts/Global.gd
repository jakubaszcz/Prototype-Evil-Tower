extends Node

# Progression file
var progression_file_extension := "cfg"
var progression_file := "progression" + "." + progression_file_extension
var progression_path := "user://" + progression_file

# Ressources
var ressources_coins := 0 # IG Coins Ressources


# Abilities
var abilities_attack := 10 # Global Abilities, That Affects IG
var abilities_radius := 0 # Global Abilities, That Affects IG
var abilities_health := 0 # Global Abilities, That Affects IG

# Bonuses
var start_coin := 0

# Load Progression
func load_progression():
	var config := ConfigFile.new()
	var error = config.load(progression_path)
	if error == OK:
		ressources_coins = config.get_value("progress", "coins", 0)
		abilities_health = config.get_value("progress", "attack", 10)
		abilities_radius = config.get_value("progress", "radius", 10)
		abilities_health = config.get_value("progress", "health", 10)
		start_coin = config.get_value("progress", "coin", 0)
	else:
		print("No save have been found.")

# Save Progression
func save_progression():
	var config = ConfigFile.new()
	config.get_value("progress", "coins", ressources_coins)
	config.get_value("progress", "attack", abilities_attack)
	config.get_value("progress", "radius", abilities_radius)
	config.get_value("progress", "health", abilities_health)
	config.get_value("progress", "coint", start_coin)
	config.save(progression_path)
