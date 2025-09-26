extends CharacterBody2D

@onready var can_shoot : bool = true
@onready var shoot_cooldown = $ShootCooldown 

@onready var projectile_scene = load("res://Components/Utils/Projectiles.tscn")
@onready var detection_area: Area2D = $RadiusArea

func _physics_process(delta: float) -> void:
	if not can_shoot: return
	for overlaps in detection_area.get_overlapping_bodies():
		if overlaps.is_in_group("enemy"):
			print("there is someone")
			_shoot(overlaps)

func _on_radius_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and can_shoot:
		_shoot(body)

func _shoot(body: Node2D) -> void:
	var projectile = projectile_scene.instantiate()
	can_shoot = false
	projectile.global_position = global_position
	projectile._set_target(body)
	get_parent().add_child(projectile)
	


func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true
