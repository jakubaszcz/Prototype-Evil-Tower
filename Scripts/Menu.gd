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

# Regeneration Shop
@onready var base_regeneration_price : int = 32
@onready var base_regeneration_multiplier : float = 1.83
@onready var base_regeneration_reward : float = 0.2

# Ruse Shop
@onready var base_ruse_price : int = 75
@onready var base_ruse_multiplier : float = 1.60
@onready var base_ruse_reward : float = 0.25

# Gems Label
@onready var gems_shop_label : Label = $VBoxContainer/MarginContainerPanel/PanelContainer/MarginContainer/GridContainer/Sapphire
@onready var score_wave_label : Label = $VBoxContainer/MarginContainerPanel/PanelContainer/MarginContainer/GridContainer/Score

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

# Regeneration Shop Label
@onready var regeneration_shop_level_label : Label = $VBoxContainer/ScrollContainer/GridContainer/RegenerationShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var regeneration_shop_price_label : Label = $VBoxContainer/ScrollContainer/GridContainer/RegenerationShop/MarginContainer/VBoxContainer/GridContainer/Price
@onready var regeneration_shop_bonus_label : Label = $VBoxContainer/ScrollContainer/GridContainer/RegenerationShop/MarginContainer/VBoxContainer/GridContainer/Bonus

# Ruse Shop Label
@onready var ruse_shop_level_label : Label = $VBoxContainer/ScrollContainer/GridContainer/RuseShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var ruse_shop_price_label : Label = $VBoxContainer/ScrollContainer/GridContainer/RuseShop/MarginContainer/VBoxContainer/GridContainer/Price
@onready var ruse_shop_bonus_label : Label = $VBoxContainer/ScrollContainer/GridContainer/RuseShop/MarginContainer/VBoxContainer/GridContainer/Bonus


@onready var gameplay_time_button = $VBoxContainer/MarginContainerButton/GridContainer/TimeButton

func _ready() -> void:
	Global.load_progression()
	
	load_gems()
	load_score()
	
	load_time()
	
	load_damage_shop()
	load_health_shop()
	load_radius_shop()
	load_cadence_shop()
	load_coin_shop()
	load_bullet_shop()
	load_regeneration_shop()
	load_ruse_shop()

func save_progression():
	Global.save_progression()

func load_time():
	gameplay_time_button.text = "x" + str(Global.gameplay_times_array[Global.gameplay_time])

func load_gems():
	gems_shop_label.text = Utils.format_number(Global.sapphire) + " Sapphire"

func load_score():
	score_wave_label.text = "Highest wave : " + str(Global.score_wave)

func default_damage_shop():
	base_damage_price = 12

func load_damage_shop():
	default_damage_shop()
	
	base_damage_price = int(round(base_damage_price * pow(base_damage_multiplier, Global.bonus_damage_level)))

	damage_shop_level_label.text = "Lv." + Utils.format_number(Global.bonus_damage_level)
	damage_shop_price_label.text = Utils.format_number(base_damage_price)
	damage_shop_bonus_label.text = Utils.format_number(Global.bonus_damage)

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

	health_shop_level_label.text = "Lv." + Utils.format_number(Global.bonus_health_level)
	health_shop_price_label.text = Utils.format_number(base_health_price)
	health_shop_bonus_label.text = Utils.format_number(Global.bonus_health)

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
	
	if (Global.bonus_radius_level >= 50):
		radius_shop_level_label.text = "Lv." + Utils.format_number(Global.bonus_radius_level) + "( Max )"
	else:
		radius_shop_level_label.text = "Lv." + Utils.format_number(Global.bonus_radius_level)
	radius_shop_price_label.text = Utils.format_number(base_radius_price)
	radius_shop_bonus_label.text = Utils.format_number(Global.bonus_radius)

func _on_radius_button_pressed() -> void:
	if (Global.bonus_radius_level >= 50): return
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
	
	if (Global.bonus_cadence_level >= 15):
		cadence_shop_level_label.text = "Lv." + Utils.format_number(Global.bonus_cadence_level) + "( Max )"
	else:
		cadence_shop_level_label.text = "Lv." + Utils.format_number(Global.bonus_cadence_level)
	cadence_shop_price_label.text = Utils.format_number(base_cadence_price)
	cadence_shop_bonus_label.text = Utils.format_number(Global.bonus_cadence)

func _on_cadence_button_pressed() -> void:
	if (Global.bonus_cadence_level >= 15): return
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

	coin_shop_level_label.text = "Lv." + Utils.format_number(Global.bonus_coin_level)
	coin_shop_price_label.text = Utils.format_number(base_coin_price)
	coin_shop_bonus_label.text = Utils.format_number(Global.bonus_coin)

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

	bullet_shop_level_label.text = "Lv." + Utils.format_number(Global.bonus_bullet_level)
	bullet_shop_price_label.text = Utils.format_number(base_bullet_price)
	bullet_shop_bonus_label.text = Utils.format_number(Global.bonus_bullet)

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

	if (Global.bonus_regeneration_level >= 15):
		regeneration_shop_level_label.text = "Lv." + Utils.format_number(Global.bonus_regeneration_level) + "( Max )"
	else:
		regeneration_shop_level_label.text = "Lv." + Utils.format_number(Global.bonus_regeneration_level)
	regeneration_shop_price_label.text = Utils.format_number(base_regeneration_price)
	regeneration_shop_bonus_label.text = Utils.format_number(Global.bonus_regeneration)

func _on_regeneration_button_pressed() -> void:
	if Global.bonus_regeneration_level >= 15: return
	if Global.sapphire >= base_regeneration_price:
		Global.bonus_regeneration_level += 1
		Global.bonus_regeneration += base_regeneration_reward
		Global.sapphire -= base_regeneration_price

		load_regeneration_shop()

		load_gems()
		
		save_progression()

func default_ruse_shop():
	base_ruse_price = 75

func load_ruse_shop():
	default_ruse_shop()
	
	base_ruse_price = int(round(base_ruse_price * pow(base_ruse_multiplier, Global.bonus_ruse_level)))

	if (Global.bonus_ruse_level >= 100):
		ruse_shop_level_label.text = "Lv." + Utils.format_number(Global.bonus_ruse_level) + "( Max )"
	else:
		ruse_shop_level_label.text = "Lv." + Utils.format_number(Global.bonus_ruse_level)
	ruse_shop_price_label.text = Utils.format_number(base_ruse_price)
	ruse_shop_bonus_label.text = Utils.format_number(Global.bonus_ruse)


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Components/Scenes/testGame.tscn")


func _on_time_button_pressed() -> void:
	
	Global.gameplay_time += 1
	if Global.gameplay_time >= Global.gameplay_times_array.size():
		Global.gameplay_time = 0

	load_time()
	
	save_progression()


func _on_ruse_button_pressed() -> void:
	if Global.bonus_ruse_level >= 100: return
	if Global.sapphire >= base_ruse_price:
		Global.bonus_ruse_level += 1
		Global.bonus_ruse += base_ruse_reward
		Global.sapphire -= base_ruse_price

		load_ruse_shop()

		load_gems()
		
		save_progression()
