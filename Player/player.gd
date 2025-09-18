class_name Player
extends CharacterBody2D

@export var move_speed: float = 200
@export var max_health: float = 100
@export var skills: Dictionary[int, Node2D] = {}

var health: float

var is_moving: bool = false

signal player_died

func _ready() -> void:
	health = max_health

func _process(delta: float) -> void:
	handle_idle_animation()
	handle_turn()
	handle_move_animation()

func handle_idle_animation() -> void:
	if not $AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play("idle")

func handle_turn() -> void:
	if Input.is_action_just_pressed("MoveRight"):
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_just_pressed("MoveLeft"):
		$AnimatedSprite2D.flip_h = true

func handle_move_animation() -> void:
	if is_moving:
		$AnimatedSprite2D.play("move")
	elif $AnimatedSprite2D.animation == "move":
		$AnimatedSprite2D.stop()

func _physics_process(delta: float) -> void:
	handle_move()

func handle_move() -> void:
	velocity = Vector2.ZERO
	var direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	if direction.length() > 0:
		is_moving = true
	else:
		is_moving = false
	velocity = direction * move_speed
	move_and_slide()

func add_skill(skill_scene: Resource, skill_position: int) -> void:
	update_marker_list()
	var skill = skill_scene.instantiate()
	if skills.get(skill_position):
		remove_child(skills[skill_position])
		skills[skill_position] = skill
		add_child(skill)
		skill.init_skill($CanvasLayer/HUD.marker_list[skill_position].global_position)
	else:
		skills[skill_position] = skill
		add_child(skill)
		skill.init_skill($CanvasLayer/HUD.marker_list[skill_position].global_position)

func update_marker_list() -> void:
	$CanvasLayer/HUD.update_marker_list()

func take_damage(damage) -> void:
	health -= damage
	$CanvasLayer/HUD.update_health(health / max_health * 100)
	if health <= 0:
		player_died.emit()
