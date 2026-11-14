
extends CharacterBody2D

@export var speed: float = 250.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction := Vector2.ZERO

	# Keyboard movement
	if Input.is_physical_key_pressed(KEY_W) or Input.is_physical_key_pressed(KEY_UP):
		direction.y -= 1

	if Input.is_physical_key_pressed(KEY_S) or Input.is_physical_key_pressed(KEY_DOWN):
		direction.y += 1

	if Input.is_physical_key_pressed(KEY_A) or Input.is_physical_key_pressed(KEY_LEFT):
		direction.x -= 1

	if Input.is_physical_key_pressed(KEY_D) or Input.is_physical_key_pressed(KEY_RIGHT):
		direction.x += 1

	# Smooth movement
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

	# Character animations
	if direction == Vector2.ZERO:
		animated_sprite.play("idle")

	elif abs(direction.x) > abs(direction.y):
		animated_sprite.play("walk_right")
		animated_sprite.flip_h = direction.x < 0

	elif direction.y < 0:
		animated_sprite.flip_h = false
		animated_sprite.play("walk_up")

	else:
		animated_sprite.flip_h = false
		animated_sprite.play("walk_down")
