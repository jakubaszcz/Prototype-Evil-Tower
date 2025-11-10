extends PanelContainer

var damage_level: int = 0
var damage_price: int = 5
var damage_bonus: float = 0.0
var damage_amount : int = 5
var damage_multiplier: float = 0.22
var damage_price_multiplier: float = 1.13
var damage_max_level : int = 100

# HEALTH
var health_level: int = 0
var health_price: int = 5
var health_bonus: float = 0
var health_amount : int = 22
var health_multiplier: float = 6
var health_price_multiplier: float = 1.36

# RADIUS
var radius_level: int = 0
var radius_price: int = 6
var radius_bonus: float = 0
var radius_amount : float = 1.2
var radius_multiplier: float = 0.01
var radius_price_multiplier: float = 1.13

# CADENCE
var cadence_level: int = 0
var cadence_price: int = 8
var cadence_bonus: float = 0
var cadence_amount : float = 3.5
var cadence_multiplier: float = 0.01
var cadence_price_multiplier: float = 1.17

# BULLET
var bullet_level: int = 0
var bullet_price: int = 26
var bullet_bonus: float = 0
var bullet_amount : float = 1
var bullet_price_multiplier: float = 1.61

# REGENERATION
var regeneration_level: int = 0
var regeneration_price: int = 9
var regeneration_bonus: float = 0
var regeneration_amount : float = 1
var regeneration_multiplier: float = 0.01
var regeneration_price_multiplier: float = 1.61


# DAMAGE
@onready var damage_level_label: Label = $MarginContainer/ScrollContainer/GridContainer/DamageShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var damage_bonus_label: Label = $MarginContainer/ScrollContainer/GridContainer/DamageShop/MarginContainer/VBoxContainer/GridContainer/Bonus
@onready var damage_price_label: Label = $MarginContainer/ScrollContainer/GridContainer/DamageShop/MarginContainer/VBoxContainer/GridContainer/Price

# HEALTH
@onready var health_level_label: Label = $MarginContainer/ScrollContainer/GridContainer/HealthShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var health_bonus_label: Label = $MarginContainer/ScrollContainer/GridContainer/HealthShop/MarginContainer/VBoxContainer/GridContainer/Bonus
@onready var health_price_label: Label = $MarginContainer/ScrollContainer/GridContainer/HealthShop/MarginContainer/VBoxContainer/GridContainer/Price

# RADIUS
@onready var radius_level_label: Label = $MarginContainer/ScrollContainer/GridContainer/RadiusShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var radius_bonus_label: Label = $MarginContainer/ScrollContainer/GridContainer/RadiusShop/MarginContainer/VBoxContainer/GridContainer/Bonus
@onready var radius_price_label: Label = $MarginContainer/ScrollContainer/GridContainer/RadiusShop/MarginContainer/VBoxContainer/GridContainer/Price

# CADENCE
@onready var cadence_level_label: Label = $MarginContainer/ScrollContainer/GridContainer/CadenceShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var cadence_bonus_label: Label = $MarginContainer/ScrollContainer/GridContainer/CadenceShop/MarginContainer/VBoxContainer/GridContainer/Bonus
@onready var cadence_price_label: Label = $MarginContainer/ScrollContainer/GridContainer/CadenceShop/MarginContainer/VBoxContainer/GridContainer/Price

# Bullet
@onready var bullet_level_label : Label = $MarginContainer/ScrollContainer/GridContainer/BulletShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var bullet_bonus_label : Label = $MarginContainer/ScrollContainer/GridContainer/BulletShop/MarginContainer/VBoxContainer/GridContainer/Bonus
@onready var bullet_price_label : Label = $MarginContainer/ScrollContainer/GridContainer/BulletShop/MarginContainer/VBoxContainer/GridContainer/Price

# Regeneration
@onready var regeneration_level_label : Label = $MarginContainer/ScrollContainer/GridContainer/RegenerationShop/MarginContainer/VBoxContainer/GridContainer/Level
@onready var regeneration_bonus_label : Label = $MarginContainer/ScrollContainer/GridContainer/RegenerationShop/MarginContainer/VBoxContainer/GridContainer/Bonus
@onready var regeneration_price_label : Label = $MarginContainer/ScrollContainer/GridContainer/RegenerationShop/MarginContainer/VBoxContainer/GridContainer/Price

var shop_map = {}


func _ready() -> void:
	GameSignal.connect("s_game_shop", Callable(self, "_on_game_shop"))
	
	shop_map = {
		"shop_damage": Callable(self, "purchase_damage"),
		"shop_health": Callable(self, "purchase_health"),
		"shop_radius": Callable(self, "purchase_radius"),
		"shop_cadence": Callable(self, "purchase_cadence"),
		"shop_bullet": Callable(self, "purchase_bullet"),
		"shop_regeneration": Callable(self, "purchase_regeneration"),
	}
	
	load_damage()
	load_health()
	load_radius()
	load_cadence()
	load_bullet()
	load_regeneration()

func _on_game_shop(item):
	if shop_map.has(item):
		shop_map[item].call()

func purchase_damage():
	if Game.game_coin < damage_price:
		return
	Game.game_coin -= damage_price

	Game.game_damage += damage_multiplier
	damage_bonus += damage_multiplier
	damage_level += 1
	damage_price = int(round(damage_price * damage_price_multiplier))
	load_damage()

func purchase_health():
	if Game.game_coin < health_price:
		return
	Game.game_coin -= health_price
	Game.game_health += health_multiplier
	health_bonus += health_multiplier
	health_level += 1
	health_price = int(round(health_price * health_price_multiplier))
	load_health()

func purchase_radius():
	if Game.game_coin < radius_price:
		return
	Game.game_coin -= radius_price
	Game.game_radius += radius_multiplier
	radius_bonus += radius_multiplier
	radius_level += 1
	radius_price = int(round(radius_price * radius_price_multiplier))
	load_radius()

func purchase_cadence():
	if Game.game_coin < cadence_price:
		return
	Game.game_coin -= cadence_price
	Game.game_cadence -= cadence_multiplier
	cadence_bonus += cadence_multiplier
	cadence_level += 1
	cadence_price = int(round(cadence_price * cadence_price_multiplier))
	load_cadence()

func purchase_bullet():
	if Game.game_coin < cadence_price:
		return
	Game.game_coin -= bullet_price
	Game.game_bullet += 1
	bullet_bonus += 1
	bullet_level += 1
	bullet_price = int(round(bullet_price * bullet_price_multiplier))
	load_bullet()

func purchase_regeneration():
	if Game.game_coin < regeneration_price:
		return
	Game.game_coin -= regeneration_price
	Game.game_regeneration -= regeneration_multiplier
	regeneration_bonus += regeneration_multiplier
	regeneration_level += 1
	regeneration_price = int(round(regeneration_price * regeneration_price_multiplier))
	load_regeneration()

func load_damage():
	if damage_level >= damage_max_level:
		damage_level_label.text = "Maxxed"
	else:
		damage_level_label.text = "Lv." + Utils.format_number(damage_level)

	damage_bonus_label.text = Utils.format_number(damage_bonus)
	damage_price_label.text = Utils.format_number(damage_price)

func load_health():
	health_level_label.text = "Lv." + Utils.format_number(health_level)
	health_bonus_label.text = Utils.format_number(round(health_bonus * 100) / 100.0)
	health_price_label.text = Utils.format_number(health_price)

func load_radius():
	radius_level_label.text = "Lv." + Utils.format_number(radius_level)
	radius_bonus_label.text = Utils.format_number(round(radius_bonus * 100) / 100.0)
	radius_price_label.text = Utils.format_number(radius_price)

func load_cadence():
	cadence_level_label.text = "Lv." + Utils.format_number(cadence_level)
	cadence_bonus_label.text = Utils.format_number(round(cadence_bonus * 100) / 100.0)
	cadence_price_label.text = Utils.format_number(cadence_price)
	
func load_bullet():
	bullet_level_label.text = "Lv." + Utils.format_number(bullet_level)
	bullet_bonus_label.text = Utils.format_number(round(bullet_bonus * 100) / 100.0)
	bullet_price_label.text = Utils.format_number(bullet_price)

func load_regeneration():
	regeneration_level_label.text = "Lv." + Utils.format_number(regeneration_level)
	regeneration_bonus_label.text = Utils.format_number(round(regeneration_bonus * 100) / 100.0)
	regeneration_price_label.text = Utils.format_number(regeneration_price)

func _on_damage_button_pressed() -> void:
	if damage_level >= damage_max_level: return
	if Game.game_coin >= damage_price:
		GameSignal.emit_signal("s_game_shop", "shop_damage")

func _on_health_button_pressed() -> void:
	if Game.game_coin >= health_price:
		GameSignal.emit_signal("s_game_shop", "shop_health")

func _on_radius_button_pressed() -> void:
	if Game.game_coin >= radius_price:
		GameSignal.emit_signal("s_game_shop", "shop_radius")

func _on_cadence_button_pressed() -> void:
	if Game.game_coin >= cadence_price:
		GameSignal.emit_signal("s_game_shop", "shop_cadence")

func _on_bullet_button_pressed() -> void:
	if Game.game_coin >= bullet_price:
		GameSignal.emit_signal("s_game_shop", "shop_bullet")

func _on_regeneration_button_pressed() -> void:
	if Game.game_coin >= bullet_price:
		GameSignal.emit_signal("s_game_shop", "shop_regeneration")
