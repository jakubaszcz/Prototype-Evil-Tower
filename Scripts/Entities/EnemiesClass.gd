extends CharacterBody2D
class_name Enemy

signal enemy_died

@export var health: int = 100
@export var speed: float = 50.0
@export var attack: float = 1.0
@export var attack_speed : float = 3.0
@export var recompense: int = 1
var is_dead: bool = false
var can_attack : bool = true

@export var progress_bar: ProgressBar
@export var cooldown: Timer
@export var hitbox: Area2D

var player_target: CharacterBody2D = null
@onready var detection_area: Area2D = $Area2D


func _ready() -> void:
	if cooldown:
		cooldown.wait_time = attack_speed
		cooldown.timeout.connect(_on_cooldown_timeout)
	if progress_bar:
		progress_bar.max_value = health
		progress_bar.value = health

func _physics_process(_delta: float) -> void:
	for players in detection_area.get_overlapping_bodies():
		if players.is_in_group("player") and can_attack:
			if cooldown:
				cooldown.start()
				can_attack = false
				_attack(players, attack)

			
	if player_target and is_instance_valid(player_target):
		var direction = (player_target.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func _attack(target : Node2D, damage: float):
	if target.is_in_group("player"):
		target._take_damage(damage)

func _set_target(target: CharacterBody2D) -> void:
	player_target = target

func _take_damage(amount: int) -> void:
	health -= amount
	if progress_bar:
		progress_bar.value = health
	
	if health <= 0:
		Game.game_coin += recompense
		is_dead = true
		emit_signal("enemy_died")
		Game.enemies_killed_count += 1
		queue_free()

func get_health() -> int:
	return health
	
func _on_cooldown_timeout() -> void:
	can_attack = true
