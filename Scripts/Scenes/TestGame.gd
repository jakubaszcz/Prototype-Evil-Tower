extends Control

# Information zone
@onready var information_health : Label = $MarginContainer/VBoxContainer/GridContainer/VBoxContainer/InfoPanel/HBoxContainer/HealthLabel
@onready var information_wave : Label = $MarginContainer/VBoxContainer/GridContainer/VBoxContainer/InfoPanel/HBoxContainer/WaveLabel

# Statistics zone
@onready var statistic_damage : Label = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainerOne/DamageLabel
@onready var statistic_health : Label = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainerOne/HealthLabel
@onready var statistic_radius : Label = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainerOne/RadiusLAbel
@onready var statisitic_cadence : Label = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainerOne/CadenceLabel
@onready var statistic_bullet : Label = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainerTwo/BulletLabel
@onready var statistic_regeneration : Label = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainerTwo/RegenerationLabel

func _physics_process(delta: float) -> void:
	load_informations()
	load_statistics()
	
func load_informations():
	information_health.text = "Curr. Wave : " + str(Game.current_wave + 1)
	information_wave.text = "Health : " + str(Game.game_current_health) + "/" + str(Game.game_health)

func load_statistics():
	statistic_damage.text = "Damage : " + str(Game.game_damage)
	statistic_health.text = "Health : " + str(Game.game_health)
	statistic_radius.text = "Radius : " + str(Game.game_radius)
	statisitic_cadence.text = "Cadence : " + str(Game.game_cadence)
	statistic_bullet.text = "Bullet : " + str(Game.game_bullet)
	statistic_regeneration.text = "Regeneration : " + str(Game.game_regeneration)
