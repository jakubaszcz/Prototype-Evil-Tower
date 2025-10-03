extends Node


var progression_path := "user://progression.cfg"

var ressources_gems : int = 0
var abilities_attack : float = 10.0
var abilities_radius : float = 0.0
var abilities_health : float = 0.0
var abilities_cadence : float = 0.0
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
		print("Save chargée :", ProjectSettings.globalize_path(progression_path))
	else:
		print("Pas de save trouvée, valeurs par défaut.")

func save_progression():
	var config = ConfigFile.new()
	config.set_value("progress", "gems", ressources_gems)
	config.set_value("progress", "attack", abilities_attack)
	config.set_value("progress", "radius", abilities_radius)
	config.set_value("progress", "health", abilities_health)
	config.set_value("progress", "cadence", abilities_cadence)
	config.set_value("progress", "coin", start_coin)

	var err = config.save(progression_path)
	if err != OK:
		push_error("Erreur de sauvegarde : " + str(err))
	else:
		print("💾 Sauvegarde réussie :", ProjectSettings.globalize_path(progression_path))
