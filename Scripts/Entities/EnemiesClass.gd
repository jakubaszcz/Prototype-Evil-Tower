extends CharacterBody2D
class_name Enemy

signal enemy_died

@export var health: int = 100
var base_health : int
@export var speed: float = 50.0
@export var attack: float = 1.0
var base_attack : float
@export var attack_speed : float = 3.0
@export var recompense: int = 81789683
var base_recompense : int = recompense
var is_dead: bool = false
var can_attack : bool = true
@export var long_distance : bool = false

@export var progress_bar: ProgressBar
@export var cooldown: Timer
@export var hitbox: Area2D

@export var critical_proof : bool = false
@export var ruse_proof : bool = false

var player_target: CharacterBody2D = null
@onready var detection_area: Area2D = $Area2D

func init_base():
	base_health = health
	base_attack = attack
	base_recompense = recompense

func _ready() -> void:
	if cooldown:
		cooldown.wait_time = attack_speed
		cooldown.timeout.connect(_on_cooldown_timeout)
	if progress_bar:
		progress_bar.max_value = health
		progress_bar.value = health

func _draw() -> void:
	if not long_distance: return
	if not detection_area:
		return
	
	var collision_shape = detection_area.get_node_or_null("CollisionShape2D")
	if not collision_shape or not collision_shape.shape:
		return
	
	var color := Color(1, 0, 0, 0.1)
	
	if collision_shape.shape is CircleShape2D:
		var radius = collision_shape.shape.radius * collision_shape.scale.x
		draw_circle(Vector2.ZERO, radius, color)
	elif collision_shape.shape is RectangleShape2D:
		var extents = collision_shape.shape.extents * collision_shape.scale
		draw_rect(Rect2(-extents, extents * 2.0), color, true)


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
		if ruse_proof:
			target._take_damage(damage)
			pass
		var dodge_probability = randi_range(0, 10000)
		if dodge_probability <= (Global.bonus_ruse * 100):
			pass
		else:
			target._take_damage(damage)

func _set_target(target: CharacterBody2D) -> void:
	player_target = target

func _set_attack(value: float) -> void:
	attack = value
	
func _get_attack() -> int:
	return attack
	
func _set_speed(value: float) -> void:
	speed = value
	
func _get_speed() -> int:
	return speed

func _set_health(value: float) -> void:
	health = value
	
func _get_health() -> int:
	return health
	
func _set_reward(value: float) -> void:
	recompense = value
	
func _get_reward() -> int:
	return recompense

func _take_damage(amount: int) -> void:
	health -= amount
	if progress_bar:
		progress_bar.value = health
	
	if health <= 0:
		Game.game_coin += recompense
		is_dead = true
		emit_signal("enemy_died")
		Game.sapphire += Global.bonus_sapphire_enemy
		Game.killed_enemy += 1
		queue_free()

func get_health() -> int:
	return health
	
func _on_cooldown_timeout() -> void:
	can_attack = true
	
func get_base_health():
	return base_health
func get_base_attack():
	return base_attack
func get_base_recompense():
	return base_recompense
func get_critical():
	return critical_proof
