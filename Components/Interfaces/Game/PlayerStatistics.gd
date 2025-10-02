extends Node

@onready var infos_label = $Infos

func _physics_process(_delta: float) -> void:
	$DamageContainer/Price.text = "Price : " + str(Game.game_damage_price)
	$DamageContainer/Ability.text = "Damage : " + str(Game.game_damage)
	
	$HealthContainer/Price.text = "Price : " + str(Game.game_health_price)
	$HealthContainer/Ability.text = "Health : " + str(Game.game_health)
	
	$RadiusContainer/Price.text = "Price : " + str(Game.game_radius_price)
	$RadiusContainer/Ability.text = "Radius : " + str(Game.game_radius)
	
	$CadenceContainer/Price.text = "Price : " + str(Game.game_cadence_price)
	$CadenceContainer/Ability.text = "Cadence : " + str(Game.game_cadence)
	
	infos_label.text =  str(Game.game_coin)


func _on_damage_pressed() -> void:
	if ((Game.game_coin - Game.game_damage_price) >= 0):
		Game.game_coin -= Game.game_damage_price
		Game.game_damage *= Game.game_damage_buy
		Game.game_damage_price *= Game.multiplier


func _on_health_pressed() -> void:
		if ((Game.game_coin - Game.game_health_price) >= 0):
			Game.game_coin -= Game.game_health_price
			Game.game_health *= Game.game_health_buy
			Game.game_health_price *= Game.multiplier


func _on_radius_pressed() -> void:
	if ((Game.game_coin - Game.game_radius_price) >= 0):
		Game.game_coin -= Game.game_radius_price
		Game.game_radius *= Game.game_radius_buy
		Game.game_radius_price *= Game.multiplier


func _on_cadence_pressed() -> void:
	if ((Game.game_coin - Game.game_cadence_price) >= 0):
		Game.game_coin -= Game.game_cadence_price
		Game.game_cadence *= Game.game_cadence_buy
		Game.game_cadence_price *= Game.multiplier
