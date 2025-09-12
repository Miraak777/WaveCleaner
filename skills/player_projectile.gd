extends Area2D

var damage: float = 0
var direction: Vector2 = Vector2.ZERO
var move_speed: float = 0

func _physics_process(delta: float) -> void:
	global_position += direction * move_speed * delta

func _on_body_entered(body: Node2D) -> void:
	body.take_damage(damage)
	queue_free()
