extends CharacterBody2D
class_name Enemy

@export var health: int = 100
@export var speed: float = 50.0
@export var recompense: int = 1
var is_dead: bool = false

@export var progress_bar: ProgressBar
@export var hitbox: Area2D

var player_target: CharacterBody2D = null

func _ready() -> void:
	if progress_bar:
		progress_bar.max_value = health
		progress_bar.value = health

func _physics_process(_delta: float) -> void:
	if player_target and is_instance_valid(player_target):
		var direction = (player_target.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func _set_target(target: CharacterBody2D) -> void:
	player_target = target

func _take_damage(amount: int) -> void:
	health -= amount
	if progress_bar:
		progress_bar.value = health
	
	if health <= 0:
		Game.game_coin += recompense
		is_dead = true
		queue_free()

func get_health() -> int:
	return health
