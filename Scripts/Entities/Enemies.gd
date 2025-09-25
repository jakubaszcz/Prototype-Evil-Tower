extends CharacterBody2D

var enemy_speed := 200.0
@export var player : CharacterBody2D


func _physics_process(delta: float) -> void:
	if !player: return
	var direction = (player.global_position - self.global_position).normalized()
	velocity = direction * enemy_speed
	move_and_slide()
