extends Area2D

@export var speed = 50 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector. defaul (0,0)
	$WalkAnimation.play("walk")
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("swing"):
		
		$SwingAnimation.play("swing")
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed # faster diagonal
		
	$Body.position += velocity * delta
	$Body.position = $Body.position.clamp(Vector2.ZERO, screen_size)
