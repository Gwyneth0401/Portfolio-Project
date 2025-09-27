extends CharacterBody2D

@export var speed = 100
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var joystick = $"../MobileControls/Joystick"

var can_move = true		# allow/disallow movement

func _physics_process(_delta: float) -> void:
	if not can_move:
		velocity = Vector2.ZERO
		animation.stop()
		return
	
	# Read directional input
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if joystick.visible and joystick.direction != Vector2.ZERO:
		direction = joystick.direction
	
	velocity = direction * speed
	
	# Play correct animation
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				animation.play("walk_right")
			else:
				animation.play("walk_left")
		else:
			if direction.y > 0:
				animation.play("walk_down")
			else:
				animation.play("walk_up")
	else:
		animation.stop() # idle

	move_and_slide()
