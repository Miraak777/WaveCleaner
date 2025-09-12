extends CharacterBody2D

@export var player: CharacterBody2D
@export var move_speed: float = 30
@export var damage: float = 5
@export var dealing_damage_cooldown_time: float = 1

var dealing_damage_cooldown_time_left: float = 0

func _process(delta: float) -> void:
	handle_move()
	if $AttackArea2D.overlaps_body(player):
		deal_damage_to_player()
	handle_cooldown(delta)
	move_and_slide()

func handle_move() -> void:
	var player_direction = (player.global_position - global_position).normalized()
	$Sprite2D.flip_h = player_direction > Vector2.ZERO
	velocity = player_direction * move_speed

func deal_damage_to_player() -> void:
	if dealing_damage_cooldown_time_left <= 0:
		player.take_damage(damage)
		dealing_damage_cooldown_time_left = dealing_damage_cooldown_time

func handle_cooldown(delta: float) -> void:
	if dealing_damage_cooldown_time_left > 0:
		dealing_damage_cooldown_time_left -= delta
