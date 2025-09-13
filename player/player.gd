extends CharacterBody2D

@export var base_move_speed: float = 200
@export var base_max_health: float = 100

var move_speed: float
var max_health: float
var health: float

var is_moving: bool = false

signal player_died

func _ready() -> void:
	move_speed = base_move_speed
	max_health = base_max_health
	health = max_health
	$Shoot.projectile_speed = 200
	$Shoot.damage = 5

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
	handle_shoot()

func handle_move() -> void:
	velocity = Vector2.ZERO
	var direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	if direction.length() > 0:
		is_moving = true
	else:
		is_moving = false
	velocity = direction * move_speed
	move_and_slide()

func handle_shoot() -> void:
	if Input.is_key_pressed(KEY_F):
		$Shoot/Timer.start()
	elif Input.is_key_pressed(KEY_G):
		$Shoot/Timer.stop()
		

func take_damage(damage) -> void:
	health -= damage
	if health < 0:
		player_died.emit()
