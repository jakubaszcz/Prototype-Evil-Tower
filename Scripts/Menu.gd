extends Control

# Damage Shop
@onready var base_damage_price : int = 12
@onready var base_damage_multiplier : float = 1.25
@onready var base_damage_reward : int = 1

# Health Shop
@onready var base_health_price : int = 13
@onready var base_health_multiplier : float = 1.30
@onready var base_health_reward : int = 2

# Radius Shop
@onready var base_radius_price : int = 15
@onready var base_radius_multiplier : float = 1.35
@onready var base_radius_reward : float = 0.15

# Cadence Shop
@onready var base_cadence_price : int = 17
@onready var base_cadence_multiplier : float = 1.40
@onready var base_cadence_reward : float = 0.10

# Coin Shop
@onready var base_coin_price : int = 23
@onready var base_coin_multiplier : float = 1.30
@onready var base_coin_reward : int = 2

# Bullet Shop
@onready var base_bullet_price : int = 89
@onready var base_bullet_multiplier : float = 1.65
@onready var base_bullet_reward : int = 1

# bonus_regeneration Shop
@onready var base_regeneration_price : int = 24
@onready var base_regeneration_multiplier : float = 1.60
@onready var base_regeneration_reward : float = 0.2

# Gems Label
@onready var gems_shop_label : Label = $VBoxContainer/MarginContainerPanel/PanelContainer/MarginContainer/Label

# Damage Shop Label
@onready var damage_shop_level_label : Label = $VBoxContainer/ScrollContainer/GridContainer/DamageShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var damage_shop_price_label : Label = $VBoxContainer/ScrollContainer/GridContainer/DamageShop/MarginContainer/VBoxContainer/GridContainer/Price
@onready var damage_shop_bonus_label : Label = $VBoxContainer/ScrollContainer/GridContainer/DamageShop/MarginContainer/VBoxContainer/GridContainer/Bonus

# Health Shop Label
@onready var health_shop_level_label : Label = $VBoxContainer/ScrollContainer/GridContainer/HealthShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var health_shop_price_label : Label = $VBoxContainer/ScrollContainer/GridContainer/HealthShop/MarginContainer/VBoxContainer/GridContainer/Price
@onready var health_shop_bonus_label : Label = $VBoxContainer/ScrollContainer/GridContainer/HealthShop/MarginContainer/VBoxContainer/GridContainer/Bonus

# Radius Shop Label
@onready var radius_shop_level_label : Label = $VBoxContainer/ScrollContainer/GridContainer/RadiusShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var radius_shop_price_label : Label = $VBoxContainer/ScrollContainer/GridContainer/RadiusShop/MarginContainer/VBoxContainer/GridContainer/Price
@onready var radius_shop_bonus_label : Label = $VBoxContainer/ScrollContainer/GridContainer/RadiusShop/MarginContainer/VBoxContainer/GridContainer/Bonus

# Cadence Shop Label
@onready var cadence_shop_level_label : Label = $VBoxContainer/ScrollContainer/GridContainer/CadenceShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var cadence_shop_price_label : Label = $VBoxContainer/ScrollContainer/GridContainer/CadenceShop/MarginContainer/VBoxContainer/GridContainer/Price
@onready var cadence_shop_bonus_label : Label = $VBoxContainer/ScrollContainer/GridContainer/CadenceShop/MarginContainer/VBoxContainer/GridContainer/Bonus

# Coin Shop Label
@onready var coin_shop_level_label : Label = $VBoxContainer/ScrollContainer/GridContainer/CoinShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var coin_shop_price_label : Label = $VBoxContainer/ScrollContainer/GridContainer/CoinShop/MarginContainer/VBoxContainer/GridContainer/Price
@onready var coin_shop_bonus_label : Label = $VBoxContainer/ScrollContainer/GridContainer/CoinShop/MarginContainer/VBoxContainer/GridContainer/Bonus

# Bullet Shop Label
@onready var bullet_shop_level_label : Label = $VBoxContainer/ScrollContainer/GridContainer/BulletShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var bullet_shop_price_label : Label = $VBoxContainer/ScrollContainer/GridContainer/BulletShop/MarginContainer/VBoxContainer/GridContainer/Price
@onready var bullet_shop_bonus_label : Label = $VBoxContainer/ScrollContainer/GridContainer/BulletShop/MarginContainer/VBoxContainer/GridContainer/Bonus

# bonus_regeneration Shop Label
@onready var regeneration_shop_level_label : Label = $VBoxContainer/ScrollContainer/GridContainer/RegenerationShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var regeneration_shop_price_label : Label = $VBoxContainer/ScrollContainer/GridContainer/RegenerationShop/MarginContainer/VBoxContainer/GridContainer/Price
@onready var regeneration_shop_bonus_label : Label = $VBoxContainer/ScrollContainer/GridContainer/RegenerationShop/MarginContainer/VBoxContainer/GridContainer/Bonus

func _ready() -> void:
	Global.load_progression()
	
	load_gems()
	
	load_damage_shop()
	load_health_shop()
	load_radius_shop()
	load_cadence_shop()
	load_coin_shop()
	load_bullet_shop()
	load_regeneration_shop()

func save_progression():
	Global.save_progression()

func load_gems():
	gems_shop_label.text = str(Global.sapphire)

func default_damage_shop():
	base_damage_price = 12

func load_damage_shop():
	default_damage_shop()
	
	base_damage_price = int(round(base_damage_price * pow(base_damage_multiplier, Global.bonus_damage_level)))

	damage_shop_level_label.text = "Lv." + str(Global.bonus_damage_level)
	damage_shop_price_label.text = str(base_damage_price)
	damage_shop_bonus_label.text = str(Global.bonus_damage)

func _on_damage_button_pressed() -> void:
	if Global.sapphire >= base_damage_price:
		Global.bonus_damage_level += 1
		Global.bonus_damage += base_damage_reward
		Global.sapphire -= base_damage_price
		
		load_damage_shop()
		
		load_gems()
		
		save_progression()

func default_health_shop():
	base_health_price = 13

func load_health_shop():
	default_health_shop()

	base_health_price = int(round(base_health_price * pow(base_health_multiplier, Global.bonus_health_level)))

	health_shop_level_label.text = "Lv." + str(Global.bonus_health_level)
	health_shop_price_label.text = str(base_health_price)
	health_shop_bonus_label.text = str(Global.bonus_health)

func _on_health_button_pressed() -> void:
	if Global.sapphire >= base_health_price:
		Global.bonus_health_level += 1
		Global.bonus_health += base_health_reward
		Global.sapphire -= base_health_price

		load_health_shop()

		load_gems()
		
		save_progression()

func default_radius_shop():
	base_radius_price = 15

func load_radius_shop():
	default_radius_shop()

	base_radius_price = int(round(base_radius_price * pow(base_radius_multiplier, Global.bonus_radius_level)))

	radius_shop_level_label.text = "Lv." + str(Global.bonus_radius_level)
	radius_shop_price_label.text = str(base_radius_price)
	radius_shop_bonus_label.text = str(Global.bonus_radius)

func _on_radius_button_pressed() -> void:
	if Global.sapphire >= base_radius_price:
		Global.bonus_radius_level += 1
		Global.bonus_radius += base_radius_reward
		Global.sapphire -= base_radius_price
		
		load_radius_shop()
		
		load_gems()
		
		save_progression()

func default_cadence_shop():
	base_cadence_price = 17

func load_cadence_shop():
	default_cadence_shop()

	base_cadence_price = int(round(base_cadence_price * pow(base_cadence_multiplier, Global.bonus_cadence_level)))

	cadence_shop_level_label.text = "Lv." + str(Global.bonus_cadence_level)
	cadence_shop_price_label.text = str(base_cadence_price)
	cadence_shop_bonus_label.text = str(Global.bonus_cadence)

func _on_cadence_button_pressed() -> void:
	if Global.sapphire >= base_cadence_price:
		Global.bonus_cadence_level += 1
		Global.bonus_cadence += base_cadence_reward
		Global.sapphire -= base_cadence_price

		load_cadence_shop()

		load_gems()
		
		save_progression()

func default_coin_shop():
	base_coin_price = 23

func load_coin_shop():
	default_coin_shop()

	base_coin_price = int(round(base_coin_price * pow(base_coin_multiplier, Global.bonus_coin)))

	coin_shop_level_label.text = "Lv." + str(Global.bonus_coin_level)
	coin_shop_price_label.text = str(base_coin_price)
	coin_shop_bonus_label.text = str(Global.bonus_coin)

func _on_coin_button_pressed() -> void:
	if Global.sapphire >= base_coin_price:
		Global.bonus_coin_level += 1
		Global.bonus_coin += base_coin_reward
		Global.sapphire -= base_coin_price
		
		load_coin_shop()

		load_gems()
		
		save_progression()

func default_bullet_shop():
	base_bullet_price = 89

func load_bullet_shop():
	default_bullet_shop()

	base_bullet_price = int(round(base_bullet_price * pow(base_bullet_multiplier, Global.bonus_bullet_level)))

	bullet_shop_level_label.text = "Lv." + str(Global.bonus_bullet_level)
	bullet_shop_price_label.text = str(base_bullet_price)
	bullet_shop_bonus_label.text = str(Global.bonus_bullet)

func _on_bullet_button_pressed() -> void:
	if Global.sapphire >= base_bullet_price:
		Global.bonus_bullet_level += 1
		Global.bonus_bullet += base_bullet_reward
		Global.sapphire -= base_bullet_price
		
		load_bullet_shop()

		load_gems()
		
		save_progression()

func default_regeneration_shop():
	base_regeneration_price = 24

func load_regeneration_shop():
	default_regeneration_shop()

	base_regeneration_price = int(round(base_regeneration_price * pow(base_regeneration_multiplier, Global.bonus_regeneration_level)))

	regeneration_shop_level_label.text = "Lv." + str(Global.bonus_regeneration_level)
	regeneration_shop_price_label.text = str(base_regeneration_price)
	regeneration_shop_bonus_label.text = str(Global.bonus_regeneration)

func _on_regeneration_button_pressed() -> void:
	if Global.sapphire >= base_regeneration_price:
		Global.bonus_regeneration_level += 1
		Global.bonus_regeneration += base_regeneration_reward
		Global.sapphire -= base_regeneration_price

		load_regeneration_shop()

		load_gems()
		
		save_progression()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Components/Scenes/Game.tscn")
