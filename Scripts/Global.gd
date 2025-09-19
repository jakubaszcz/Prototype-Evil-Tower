extends Node

# Progression file
var progression_file_extension := "cfg"
var progression_file := "progression" + "." + progression_file_extension
var progression_path := "user://" + progression_file

# Ressources
var ressources_coins := 0

func load_progression():
	var config := ConfigFile.new()
	var error = config.load(progression_path)
	if error == OK:
		Global.ressources_coins = config.get_value("progress", "coins", 0)
	else:
		print("No save hve been found.")

func save_progression():
	var config = ConfigFile.new()
	config.set_value("progress", "coins", ressources_coins)
	config.save(progression_path)
