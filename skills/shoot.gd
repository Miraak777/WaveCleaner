extends Node2D

@export var projectile_scene: PackedScene
var damage: float = 0
var projectile_speed: float = 0


func _on_timer_timeout() -> void:
	var bodies_in_area: Array = $Area2D.get_overlapping_bodies()
	if bodies_in_area:
		var min_distance_to_body: float = 10000
		var target_body: Node2D
		for body in bodies_in_area:
			var distance_to_body: float = global_position.distance_to(body.global_position)
			if distance_to_body < min_distance_to_body:
				min_distance_to_body = distance_to_body
				target_body = body
		var projectile: Node = projectile_scene.instantiate()
		get_tree().current_scene.add_child(projectile)
		projectile.global_position = global_position
		projectile.damage = damage
		projectile.move_speed = projectile_speed
		projectile.direction = global_position.direction_to(target_body.global_position)
