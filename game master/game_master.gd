extends Node2D
@export var player: CharacterBody2D
@export var stages: Array[StageData]

@export var stage_time: float = 90
@export var wave_cooldown: float = 5
@export var step_from_screen_edge: float = 20
@export var current_stage: int = 0

var spawn_rect_edges: Array[Array]
var spawn_rect_height: float
var spawn_rect_width: float


func _ready() -> void:
	$WaveTimer.wait_time = wave_cooldown
	$StageTimer.wait_time = stage_time


func _on_wave_timer_timeout() -> void:
	calculate_spawn_rect()
	var enemies_spawn_data: Array[EnemySpawnData] = stages[current_stage].waves.pick_random().enemies
	for spawn_data in enemies_spawn_data:
		var enemy_count: int = randi_range(spawn_data.min_count, spawn_data.max_count)
		for i in range(enemy_count):
			var enemy: CharacterBody2D = spawn_data.enemy.instantiate()
			enemy.global_position = get_random_position()
			enemy.player = player
			owner.add_child(enemy)

func calculate_spawn_rect() -> void:
	var screen_rect: Rect2 = get_tree().current_scene.get_viewport().get_visible_rect()
	
	spawn_rect_width = screen_rect.size.x
	spawn_rect_height = screen_rect.size.y
	
	var half_width = spawn_rect_width / 2
	var half_height = spawn_rect_height / 2
	
	var top_left_viewport_corner = screen_rect.position + Vector2(-half_width, -half_height)
	
	var top_left_offset: Vector2 = Vector2(-step_from_screen_edge, - step_from_screen_edge)
	var top_left: Vector2 = top_left_viewport_corner + top_left_offset
	
	var top_right_offset: Vector2 = Vector2(step_from_screen_edge, - step_from_screen_edge)
	var top_right: Vector2 = top_left_viewport_corner + top_right_offset + Vector2(spawn_rect_width, 0)
	
	var bottom_left_offset: Vector2 = Vector2(- step_from_screen_edge, step_from_screen_edge)
	var bottom_left: Vector2 = top_left_viewport_corner + bottom_left_offset + Vector2(0, spawn_rect_height)
	
	var bottom_right_offset: Vector2 = Vector2(step_from_screen_edge, step_from_screen_edge)
	var bottom_right: Vector2 = top_left_viewport_corner + bottom_right_offset + Vector2(spawn_rect_width, spawn_rect_height)
	
	spawn_rect_edges = [
		[top_left, top_right],
		[bottom_left, bottom_right],
		[top_left, bottom_left],
		[top_right, bottom_right]
	]

func get_random_position() -> Vector2:
	var total_edge_weight = spawn_rect_width + spawn_rect_height
	var edge_selector_value = randf() * total_edge_weight
	var edge: Array
	if edge_selector_value <= spawn_rect_width:
		edge = spawn_rect_edges[randi_range(0, 1)]
	else:
		edge = spawn_rect_edges[randi_range(2, 3)]
	var player_position_offeset: Vector2 = get_tree().current_scene.get_viewport().get_camera_2d().get_screen_center_position()
	var random_point = randf()
	return edge[0].lerp(edge[1], randf()) + player_position_offeset
	
