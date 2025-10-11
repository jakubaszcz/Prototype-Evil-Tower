extends Node2D

# ───────────────────────────────
# ⚙️ CONFIGURATION DU SHOP PERMANENT
# ───────────────────────────────

# 💰 Base Prices
@onready var base_attack_price : int = 12
@onready var base_health_price : int = 13
@onready var base_radius_price : int = 15
@onready var base_cadence_price : int = 17
@onready var base_bonus_coin_price : int = 19

# 📈 Multiplicateurs de prix
@onready var attack_price_multiplier : float = 1.25
@onready var health_price_multiplier : float = 1.30
@onready var radius_price_multiplier : float = 1.35
@onready var cadence_price_multiplier : float = 1.40
@onready var bonus_coin_price_multiplier : float = 1.30

# 🎁 Récompenses par upgrade
@onready var attack_reward : int = 2
@onready var health_reward : int = 3
@onready var radius_reward : float = 0.15
@onready var cadence_reward : float = 0.10
@onready var bonus_coin_reward : int = 3

# ⏱️ Limites (anti cheat)
@onready var cadence_min : float = 0.8

# ───────────────────────────────
# 🧾 UI REFERENCES
# ───────────────────────────────

@onready var gems_label : Label = $CanvasLayer/Gems

@onready var attack_price_label : Label = $CanvasLayer/Shop/Damage/Price
@onready var attack_bonus_label : Label = $CanvasLayer/Shop/Damage/Bonus
@onready var attack_level_labe : Label = $CanvasLayer/Shop/Damage/Level

@onready var health_price_label : Label = $CanvasLayer/Shop/Health/Price
@onready var health_bonus_label : Label = $CanvasLayer/Shop/Health/Bonus

@onready var radius_price_label : Label = $CanvasLayer/Shop/Radius/Price
@onready var radius_bonus_label : Label = $CanvasLayer/Shop/Radius/Bonus

@onready var cadence_price_label : Label = $CanvasLayer/Shop/Cadence/Price
@onready var cadence_bonus_label : Label = $CanvasLayer/Shop/Cadence/Bonus

@onready var coin_price_label : Label = $CanvasLayer/Shop/Coins/Price
@onready var coin_bonus_label : Label = $CanvasLayer/Shop/Coins/Bonus

# ───────────────────────────────
# 🚀 READY
# ───────────────────────────────

func _ready() -> void:
	Global.load_progression()
	_update_ui()

func _physics_process(_delta: float) -> void:
	_update_ui()

# ───────────────────────────────
# 🧭 UPDATE UI
# ───────────────────────────────

func _update_ui():
	gems_label.text = "Gems : " + str(Global.ressources_gems)

	attack_price_label.text = "Price : " + str(Global.abilities_attack_price)
	attack_bonus_label.text = "Bonus Damage : " + str(Global.abilities_attack)

	health_price_label.text = "Price : " + str(Global.abilities_health_price)
	health_bonus_label.text = "Bonus Health : " + str(Global.abilities_health)

	radius_price_label.text = "Price : " + str(Global.abilities_radius_price)
	radius_bonus_label.text = "Bonus Radius : " + str(Global.abilities_radius)

	cadence_price_label.text = "Price : " + str(Global.abilities_cadence_price)
	cadence_bonus_label.text = "Bonus Cadence : " + str(round(Global.abilities_cadence * 100) / 100.0)

	coin_price_label.text = "Price : " + str(Global.bonus_coin_price)
	coin_bonus_label.text = "Bonus Coin : " + str(Global.bonus_coin)

# ───────────────────────────────
# 🏪 SHOP BUTTONS
# ───────────────────────────────

func _on_damage_pressed() -> void:
	if Global.ressources_gems >= Global.abilities_attack_price:
		Global.ressources_gems -= Global.abilities_attack_price
		Global.abilities_attack += attack_reward
		Global.abilities_attack_price = int(round(Global.abilities_attack_price * attack_price_multiplier))
		Global.abilities_attack_shop_level += 1
		Global.save_progression()

func _on_health_pressed() -> void:
	if Global.ressources_gems >= Global.abilities_health_price:
		Global.ressources_gems -= Global.abilities_health_price
		Global.abilities_health += health_reward
		Global.abilities_health_price = int(round(Global.abilities_health_price * health_price_multiplier))
		Global.abilities_health_shop_level += 1
		Global.save_progression()

func _on_radius_pressed() -> void:
	if Global.ressources_gems >= Global.abilities_radius_price:
		Global.ressources_gems -= Global.abilities_radius_price
		Global.abilities_radius += radius_reward
		Global.abilities_radius_price = int(round(Global.abilities_radius_price * radius_price_multiplier))
		Global.abilities_radius_shop_level += 1
		Global.save_progression()

func _on_cadence_pressed() -> void:
	if Global.ressources_gems >= Global.abilities_cadence_price:
		Global.ressources_gems -= Global.abilities_cadence_price
		Global.abilities_cadence = max(cadence_min, Global.abilities_cadence - cadence_reward)
		Global.abilities_cadence_price = int(round(Global.abilities_cadence_price * cadence_price_multiplier))
		Global.abilities_cadence_shop_level += 1
		Global.save_progression()

func _on_coins_pressed() -> void:
	if Global.ressources_gems >= Global.bonus_coin_price:
		Global.ressources_gems -= Global.bonus_coin_price
		Global.bonus_coin += bonus_coin_reward
		Global.bonus_coin_price = int(round(Global.bonus_coin_price * bonus_coin_price_multiplier))
		Global.bonus_coin_shop_level += 1
		Global.save_progression()

# ───────────────────────────────
# ▶️ SCENE DE JEU
# ───────────────────────────────

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Components/Scenes/Game.tscn")
