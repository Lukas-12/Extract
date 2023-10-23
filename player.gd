extends Area2D

@export var speed = 50 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	flip()
	var velocity = Vector2.ZERO # The player's movement vector. defaul (0,0)
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed # faster diagonal
		
	$Body.position += velocity * delta
	$Body.position = $Body.position.clamp(Vector2.ZERO, screen_size)

func flip():
	var direction = sign(get_global_mouse_position().x - $Body.global_position.x)
	if direction < 0:
		if $SwingAnimation.current_animation == "swingRight":
			$SwingAnimation.stop()
		$Body.set_flip_h(true)
		$WalkAnimation.play("walkLeft")
		if Input.is_action_pressed("swing"):
			$SwingAnimation.play("swingLeft")
			
		
		
	else:
		if $SwingAnimation.current_animation == "swingLeft":
			$SwingAnimation.stop()
		$Body.set_flip_h(false)
		$WalkAnimation.play("walkRight")
		if Input.is_action_pressed("swing"):
			$SwingAnimation.play_backwards("swingRight")
			
		
