extends Node2D

func _ready() -> void:
	Global.load_progression()
	Global.abilities_attack_price = 12 * pow(Global.abilities_attack_price_multiplier, Global.abilities_attack_shop_level)
	Global.abilities_health_price = 13 * pow(Global.abilities_health_price_multiplier, Global.abilities_health_shop_level)
	Global.abilities_radius_price = 15 * pow(Global.abilities_radius_price_multiplier, Global.abilities_radius_shop_level)
	Global.abilities_cadence_price = 17 * pow(Global.abilities_cadence_price_multiplier, Global.abilities_cadence_shop_level)
	



func _physics_process(delta: float) -> void:
	
	$CanvasLayer/Gems.text = "Gems : " + str(Global.ressources_gems)
	
	# Damage
	$CanvasLayer/Shop/Damage/Price.text = "Price : " +str(Global.abilities_attack_price)
	$CanvasLayer/Shop/Damage/Bonus.text = "Bonus Damage : " + str(Global.abilities_attack)
	# Health
	$CanvasLayer/Shop/Health/Price.text = "Price : " +str(Global.abilities_health_price)
	$CanvasLayer/Shop/Health/Bonus.text = "Bonus Health : " + str(Global.abilities_health)
	# Radius
	$CanvasLayer/Shop/Radius/Price.text = "Price : " +str(Global.abilities_radius_price)
	$CanvasLayer/Shop/Radius/Bonus.text = "Bonus Radius : " + str(Global.abilities_radius)
	# Cadence
	$CanvasLayer/Shop/Cadence/Price.text = "Price : " +str(Global.abilities_cadence_price)
	$CanvasLayer/Shop/Cadence/Bonus.text = "Bonus Cadence : " + str(Global.abilities_cadence)


func _on_damage_pressed() -> void:
	if Global.ressources_gems >= Global.abilities_attack_price:
		Global.ressources_gems -= Global.abilities_attack_price
		Global.abilities_attack_price = 12 * pow(Global.abilities_attack_price_multiplier, Global.abilities_attack_shop_level)
		Global.abilities_attack += Global.abilities_attack_reward
		Global.abilities_attack_shop_level += 1
		print(str(Global.abilities_attack))
		
		# Save
		Global.save_progression()

func _on_health_pressed() -> void:
	if Global.ressources_gems >= Global.abilities_health_price:
		Global.ressources_gems -= Global.abilities_health_price
		Global.abilities_health_price = 13 * pow(Global.abilities_health_price_multiplier, Global.abilities_health_shop_level)
		Global.abilities_health += Global.abilities_health_reward
		Global.abilities_health_shop_level += 1
		
		# Save
		Global.save_progression()


func _on_radius_pressed() -> void:
	if Global.ressources_gems >= Global.abilities_radius_price:
		Global.ressources_gems -= Global.abilities_radius_price
		Global.abilities_radius_price = 15 * pow(Global.abilities_radius_price_multiplier, Global.abilities_radius_shop_level)
		Global.abilities_radius += Global.abilities_radius_reward
		Global.abilities_radius_shop_level += 1
		
		# Save
		Global.save_progression()

func _on_cadence_pressed() -> void:
	if Global.ressources_gems >= Global.abilities_cadence_price:
		Global.ressources_gems -= Global.abilities_cadence_price
		Global.abilities_cadence_price = 17 * pow(Global.abilities_cadence_price_multiplier, Global.abilities_cadence_shop_level)
		Global.abilities_cadence += Global.abilities_cadence_reward
		Global.abilities_cadence_shop_level += 1
		
		# Save
		Global.save_progression()


func _on_play_pressed() -> void:
		get_tree().change_scene_to_file("res://Components/Scenes/Game.tscn")
