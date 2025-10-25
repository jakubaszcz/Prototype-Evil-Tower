extends CharacterBody2D

@onready var can_shoot : bool = true
@onready var shoot_cooldown = $ShootCooldown

@onready var projectile_scene = load("res://Components/Utils/Projectiles.tscn")
@onready var detection_area: Area2D = $RadiusArea

# On Load
@export var trigger_collider : CollisionShape2D

@onready var shape: CollisionShape2D = $RadiusArea/CollisonArea

var ammo_shoot : int = 0

var is_regen : bool = false
var regen_time : float = 0.0


func _ready() -> void:
	trigger_collider.scale = Vector2(Game.game_radius, Game.game_radius)

func _draw() -> void:
	if shape.shape is CircleShape2D:
		var r = shape.shape.radius * trigger_collider.scale.x
		draw_circle(Vector2.ZERO, r, Color(0.0, 0.0, 0.0, 0.1))
	elif shape.shape is RectangleShape2D:
		var ext = shape.shape.extents * trigger_collider.scale
		draw_rect(Rect2(-ext, ext * 2.0), Color(0.0, 0.0, 0.0, 0.1), true)

func _physics_process(delta: float) -> void:
	queue_redraw() # redraw the collision _draw
	if is_regen:
		if Game.game_current_health >= Game.game_health:
			Game.game_current_health = Game.game_health
			is_regen = false
			return
		regen_time += delta
		if regen_time >= Game.game_regeneration:
			regen_time = 0.0
			Game.game_current_health += 1

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
	if ammo_shoot >= Game.game_bullet:
		return
	ammo_shoot += 1
	shoot_cooldown.start()
	var projectile = projectile_scene.instantiate()
	can_shoot = false
	projectile.global_position = global_position
	projectile._set_target(body)
	get_parent().call_deferred("add_child", projectile)
	
func _take_damage(damage : float):
	if ((Game.game_current_health - damage) <= 0):
		Game.is_game_over = true
		GameSignal.emit_signal("s_game_over", "player_died")
		queue_free()
	else:
		Game.game_current_health -= damage
		is_regen = true

func _on_shoot_cooldown_timeout() -> void:
	ammo_shoot = 0
	can_shoot = true
