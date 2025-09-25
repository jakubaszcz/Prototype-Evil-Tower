extends CharacterBody2D

@onready var projectile_scene = load("res://Components/Utils/Projectiles.tscn")

func _on_radius_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		_shoot(body)

func _shoot(body: Node2D) -> void:
	var projectile = projectile_scene.instantiate()
	projectile.global_position = global_position
	projectile.target_position = body.global_position
	get_parent().add_child(projectile)
