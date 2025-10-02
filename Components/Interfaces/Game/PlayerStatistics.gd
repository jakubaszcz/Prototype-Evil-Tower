extends Node

@onready var infos_label = $Infos

func _physics_process(_delta: float) -> void:
	infos_label.text =  "Coins   : " + str(Game.game_coin)   + "\n" \
					  + "Health  : " + str(Game.game_health) + "\n" \
					  + "Radius  : " + str(Game.game_radius) + "\n" \
					  + "Cadence : " + str(Game.game_cadence) + "\n" \
					  + "Damage  : " + str(Game.game_damage)


func _on_damagae_pressed() -> void:
	Game.game_damage += 1

func _on_health_pressed() -> void:
	Game.game_health += 1

func _on_radius_pressed() -> void:
	Game.game_radius += 1

func _on_cadence_pressed() -> void:
	Game.game_cadence -= 0.5
