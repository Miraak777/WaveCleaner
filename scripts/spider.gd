extends CharacterBody2D

@export var player: CharacterBody2D
@export var move_speed: float = 30

func _process(delta: float) -> void:
	var player_direction = (player.global_position - global_position).normalized()
	$Sprite2D.flip_h = player_direction > Vector2.ZERO
	velocity = player_direction * move_speed
	move_and_slide()
