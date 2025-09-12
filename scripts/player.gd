extends CharacterBody2D

@export var move_speed: float = 200

var is_moving: bool = false

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
