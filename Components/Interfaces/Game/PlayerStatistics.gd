extends Node

@onready var wave_reward_canvas : CanvasLayer = $WaveUI/Reward
@onready var wave_reward_showtime : Timer = $WaveUI/Reward/ShowTime
@onready var wave_reward_text : Label = $WaveUI/Reward/Reward
@onready var infos_label = $Infos

@onready var coins_label : Label = $Coins

@onready var health_bar : Label = $HealthBar

# --- SHOP CONFIGURATION ---

var shop_damage_level : int = 0
var shop_health_level : int = 0
var shop_radius_level : int = 0
var shop_cadence_level : int = 0

const shop_damage : int = 5
const shop_health : int = 22
const shop_radius : float = 1.0
const shop_cadence : float = 5.0

# Multipliers (temporary, in-game effects)
var shop_damage_multiplier : float = 1.35
var shop_health_multiplier : float = 1.15
var shop_radius_multiplier : float = 1.03
var shop_cadence_multiplier : float = 0.97

# Price multipliers
var shop_damage_price_multiplier : float = 1.25
var shop_health_price_multiplier : float = 1.35
var shop_radius_price_multiplier : float = 1.48
var shop_cadence_price_multiplier : float = 1.40

# Base prices
var shop_damage_price : int = 9
var shop_health_price : int = 10
var shop_radius_price : int = 12
var shop_cadence_price : int = 15

# UI References
@onready var shop_damage_price_label : Label = $DamageContainer/Price
@onready var shop_damage_ability_label : Label = $DamageContainer/Ability
@onready var shop_health_price_label : Label = $HealthContainer/Price
@onready var shop_health_ability_label : Label = $HealthContainer/Ability
@onready var shop_radius_price_label : Label = $RadiusContainer/Price
@onready var shop_radius_ability_label : Label = $RadiusContainer/Ability
@onready var shop_cadence_price_label : Label = $CadenceContainer/Price
@onready var shop_cadence_ability_label : Label = $CadenceContainer/Ability

func _ready():
	wave_reward_canvas.visible = false
	var wave_manager = get_node("/root/Game/Components/Spawn/WaveManager")
	wave_manager.connect("wave_reward", Callable(self, "_on_wave_reward"))

func _physics_process(_delta: float) -> void:
	_update_damage()
	_update_health()
	_update_radius()
	_update_cadence()
	_update_coins()
	_update_current_health()

# -------------------
# --- SHOP LOGIC ---
# -------------------

func _on_wave_reward(reward):
	wave_reward_canvas.visible = true
	wave_reward_showtime.start()
	wave_reward_text.text = "You get : " + str(reward) + " coins."

func _on_show_time_timeout() -> void:
	wave_reward_canvas.visible = false

func _on_damage_pressed() -> void:
	if Game.game_coin >= shop_damage_price:
		var additional_value = (shop_damage * shop_damage_multiplier) - shop_damage
		
		Game.game_coin -= shop_damage_price
		Game.game_damage += additional_value
		shop_damage_price = int(round(shop_damage_price * shop_damage_price_multiplier))
		shop_damage_level += 1
		_update_damage()

func _on_health_pressed() -> void:
	if Game.game_coin >= shop_health_price:
		var additional_value = (shop_health * shop_health_multiplier) - shop_health
		Game.game_coin -= shop_health_price
		Game.game_health += additional_value
		shop_health_price = int(round(shop_health_price * shop_health_price_multiplier))
		shop_health_level += 1
		_update_health()

func _on_radius_pressed() -> void:
	if Game.game_coin >= shop_radius_price:
		Game.game_coin -= shop_radius_price
		Game.game_radius *= shop_radius_multiplier
		shop_radius_price = int(round(shop_radius_price * shop_radius_price_multiplier))
		shop_radius_level += 1
		_update_radius()

func _on_cadence_pressed() -> void:
	if Game.game_coin >= shop_cadence_price:
		Game.game_coin -= shop_cadence_price
		Game.game_cadence *= shop_cadence_multiplier
		shop_cadence_price = int(round(shop_cadence_price * shop_cadence_price_multiplier))
		shop_cadence_level += 1
		_update_cadence()

# -------------------
# --- UI UPDATES ---
# -------------------

func _update_damage():
	shop_damage_price_label.text = "Price : " + str(shop_damage_price)
	shop_damage_ability_label.text = "Damage : " + str(round(Game.game_damage * 100) / 100.0)

func _update_health():
	shop_health_price_label.text = "Price : " + str(shop_health_price)
	shop_health_ability_label.text = "Health : " + str(round(Game.game_health * 100) / 100.0)


func _update_radius():
	shop_radius_price_label.text = "Price : " + str(shop_radius_price)
	shop_radius_ability_label.text = "Radius : " + str(round(Game.game_radius * 100) / 100.0)


func _update_cadence():
	shop_cadence_price_label.text = "Price : " + str(shop_cadence_price)
	shop_cadence_ability_label.text = "Cadence : " + str(round(Game.game_cadence * 100) / 100.0)

func _update_current_health():
	health_bar.text = "Your health : " + str(Game.game_current_health) + "/" + str(Game.game_health)

func _update_coins():
	coins_label.text = "Coins : " + str(Game.game_coin)
