extends CharacterBody2D

@onready var can_shoot : bool = true
@onready var shoot_cooldown = $ShootCooldown

@onready var projectile_scene = load("res://Components/Utils/Projectiles.tscn")
@onready var detection_area: Area2D = $RadiusArea

# On Load
@export var cooldown : Timer
@export var trigger_collider : CollisionShape2D

func _ready():
	cooldown.wait_time = Game.game_cadence
	trigger_collider.scale.x = Game.game_radius
	trigger_collider.scale.y = Game.game_radius

func _physics_process(_delta: float) -> void:
	if not can_shoot: return
	for overlaps in detection_area.get_overlapping_bodies():
		if overlaps.is_in_group("enemy"):
			_shoot(overlaps)

func _on_radius_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and can_shoot:
		_shoot(body)

func _shoot(body: Node2D) -> void:
	var projectile = projectile_scene.instantiate()
	can_shoot = false
	projectile.global_position = global_position
	projectile._set_target(body)
	get_parent().call_deferred("add_child", projectile)
	
func _take_damage(damage : float):
	if ((Game.game_health - damage) <= 0): queue_free()
	else: Game.game_health -= damage

func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true
