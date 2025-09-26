extends CharacterBody2D

var _projectile_speed = 500
var _projectile_attack = Game.game_damage
var _projectile_turning : float = 5.0
var _target : Node2D = null
var _velocity: Vector2 = Vector2.ZERO

func _set_target(target : Node2D):
	_target = target
	

func _physics_process(delta: float) -> void:
	if _target and _target.is_inside_tree():
		var to_target = (_target.global_position - global_position).normalized()
		var desired_angle = to_target.angle()
		var current_angle: float

		if _velocity == Vector2.ZERO:
			current_angle = desired_angle
		else:
			current_angle = _velocity.angle()
		
		var angle_diff = wrapf(desired_angle - current_angle, -PI, PI)
		var max_turn = _projectile_turning * delta
		var applied = clamp(angle_diff, -max_turn, max_turn)
		var new_angle = current_angle + applied

		_velocity = Vector2.RIGHT.rotated(new_angle) * _projectile_speed
		rotation = new_angle

		velocity = _velocity
		move_and_slide()
	else:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body._take_damage(_projectile_attack)
		queue_free()
