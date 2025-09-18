extends Node2D

@export var projectile_scene: Resource = load(consts.path_to_player_projectile)
@export var damage: float = 5
@export var projectile_speed: float = 200
@export var attack_range: float = 200
@export var cooldown: float = 1

var is_ready: bool = false

func _process(delta: float) -> void:
	$CanvasLayer/Icon.value = $Timer.time_left / $Timer.wait_time
	if is_ready:
		var target: Node2D = find_target()
		if target:
			shoot(target)
			is_ready = false
			$Timer.start(cooldown)

func init_skill(ui_position) -> void:
	$CanvasLayer/Icon.global_position = ui_position
	$CanvasLayer/Icon.show()
	is_ready = true

func _on_timer_timeout() -> void:
	is_ready = true

func find_target() -> Node2D:
	var bodies_in_area: Array = $Area2D.get_overlapping_bodies()
	if bodies_in_area:
		var min_distance_to_body: float = 10000
		var target_body: Node2D
		for body in bodies_in_area:
			var distance_to_body: float = global_position.distance_to(body.global_position)
			if distance_to_body < min_distance_to_body and distance_to_body <= attack_range:
				min_distance_to_body = distance_to_body
				target_body = body
		return target_body
	return null


func shoot(target: Node2D) -> void:
	var projectile: Node = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	projectile.damage = damage
	projectile.move_speed = projectile_speed
	projectile.direction = global_position.direction_to(target.global_position)
	
