extends CharacterBody2D

@onready var can_shoot : bool = true
@onready var shoot_cooldown = $ShootCooldown

@onready var projectile_scene = load("res://Components/Utils/Projectiles.tscn")
@onready var detection_area: Area2D = $RadiusArea

# On Load
@export var trigger_collider : CollisionShape2D

@onready var shape: CollisionShape2D = $RadiusArea/CollisonArea

var ammo_per_shoot : int = 1
var ammo_shoot : int = 0

func _ready() -> void:
	trigger_collider.scale = Vector2(Game.game_radius, Game.game_radius)

func _draw() -> void:
	if shape.shape is CircleShape2D:
		var r = shape.shape.radius * trigger_collider.scale.x
		draw_circle(Vector2.ZERO, r, Color(0.0, 0.0, 0.0, 0.1))
	elif shape.shape is RectangleShape2D:
		var ext = shape.shape.extents * trigger_collider.scale
		draw_rect(Rect2(-ext, ext * 2.0), Color(0.0, 0.0, 0.0, 0.1), true)

func _physics_process(_delta: float) -> void:
	queue_redraw() # redraw the collision _draw
	shoot_cooldown.wait_time = Game.game_cadence
	trigger_collider.scale = Vector2(Game.game_radius, Game.game_radius)
	if not can_shoot: return
	for overlaps in detection_area.get_overlapping_bodies():
		if overlaps.is_in_group("enemy"):
			_shoot(overlaps)

func _on_radius_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and can_shoot:
		_shoot(body)

func _shoot(body: Node2D) -> void:
	if ammo_shoot >= ammo_per_shoot:
		return
	ammo_shoot += 1
	shoot_cooldown.start()
	var projectile = projectile_scene.instantiate()
	can_shoot = false
	projectile.global_position = global_position
	projectile._set_target(body)
	get_parent().call_deferred("add_child", projectile)
	
func _take_damage(damage : float):
	if ((Game.game_health - damage) <= 0):
		Game.is_game_over = true
		Game.end_game(Game.GameOverReason.PLAYER_DEAD)
		queue_free()
	else: Game.game_health -= damage

func _on_shoot_cooldown_timeout() -> void:
	ammo_shoot = 0
	can_shoot = true
