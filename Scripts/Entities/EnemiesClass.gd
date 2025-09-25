extends CharacterBody2D
class_name ennemies_class

@export var player_target : CharacterBody2D

@export var health : int
@export var speed : float

@export var progress_bar : ProgressBar
@export var hitbox : Area2D

func _ready() -> void:
	progress_bar.max_value = health
	progress_bar.value = health

func _physics_process(delta: float) -> void:
	if !player_target: return
	var direction = (player_target.global_position - self.global_position).normalized()
	velocity = direction * speed
	move_and_slide()
