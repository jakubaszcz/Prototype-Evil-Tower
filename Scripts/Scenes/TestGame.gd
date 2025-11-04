extends Control

# Information zone
@onready var information_health : Label = $MarginContainer/VBoxContainer/GridContainer/VBoxContainer/InfoPanel/HBoxContainer/HealthLabel
@onready var information_wave : Label = $MarginContainer/VBoxContainer/GridContainer/VBoxContainer/InfoPanel/HBoxContainer/WaveLabel

# Statistics zone
@onready var statistic_damage : Label = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainerOne/DamageLabel
@onready var statistic_health : Label = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainerOne/HealthLabel
@onready var statistic_radius : Label = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainerOne/RadiusLabel
@onready var statisitic_cadence : Label = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainerOne/CadenceLabel
@onready var statistic_bullet : Label = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainerTwo/BulletLabel
@onready var statistic_regeneration : Label = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainerTwo/RegenerationLabel

# Coins Zone
@onready var coins_label : Label = $MarginContainer/VBoxContainer/GridContainer/VBoxContainer/CoinsPanel/Label

func _physics_process(delta: float) -> void:
	load_coins()
	load_informations()
	load_statistics()
	
func load_informations():
	information_health.text = "Curr. Wave : " + Utils.format_number(Game.current_wave)
	information_wave.text = "Health : " + Utils.format_number(Game.game_current_health) + "/" + Utils.format_number(Game.game_health)

func load_statistics():
	statistic_damage.text = "Damage : " + Utils.format_number(Game.game_damage)
	statistic_health.text = "Health : " + Utils.format_number(Game.game_health)
	statistic_radius.text = "Radius : " + Utils.format_number(Game.game_radius)
	statisitic_cadence.text = "Cadence : " + Utils.format_number(Game.game_cadence)
	statistic_bullet.text = "Bullet : " + Utils.format_number(Game.game_bullet)
	statistic_regeneration.text = "Regeneration : " + Utils.format_number(Game.game_regeneration)

func load_coins():
	coins_label.text = Utils.format_number(Game.game_coin) + " Coins"
