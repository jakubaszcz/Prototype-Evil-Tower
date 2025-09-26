extends Node

@onready var coins_label = $Coins
@onready var health_label = $Health

func _physics_process(_delta: float) -> void:
	coins_label.text = "Coins : " + str(Game.game_coin)
	health_label.text = "Health : " + str(Game.game_health)
