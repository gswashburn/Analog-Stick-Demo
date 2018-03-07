extends Area2D

export (int) var speed = 300

# Player Velocity
var velocity = Vector2(0,0)
var analog_velocity = Vector2(0,0)

# screensize and player size variables
var screensize
var extents

func _ready():

	# get Screensize and determine player size
	screensize = get_viewport_rect().size
	extents = $sprite.get_texture().get_size() /4

	# Set animation speed
	$sprite/anim.playback_speed = 3

	# Set Starting Animation, Position and Size for Player
	position = Vector2(screensize.x / 2, screensize.y / 2)
	$sprite.set_scale(Vector2(2, 2))

func _process(delta):
	
	velocity = Vector2()
	
	# Process Input Keys
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1

	if Input.is_action_pressed("ui_up"):
		velocity.y -=1

	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		
	# Add in analog_velocity
	velocity += analog_velocity	

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position.x = clamp(position.x, extents.x, screensize.x - extents.x)
	position.y = clamp(position.y, extents.y, screensize.y - extents.y)

	if velocity.x != 0:
		if velocity.x > 0:
			if $sprite/anim.current_animation != "Right":
				$sprite/anim.play("Right")
		else:
			if $sprite/anim.current_animation != "Left":
				$sprite/anim.play("Left")
	elif velocity.y != 0:
		if velocity.y > 0:
			if $sprite/anim.current_animation != "Down":
				$sprite/anim.play("Down")
		else:
			if $sprite/anim.current_animation != "Up":
				$sprite/anim.play("Up")		
	else:
		if $sprite/anim.current_animation == "Right":
			$sprite/anim.play("Idle-Right")
		if $sprite/anim.current_animation == "Left":
			$sprite/anim.play("Idle-Left")
		if $sprite/anim.current_animation == "Up":
			$sprite/anim.play("Idle-Up")
		if $sprite/anim.current_animation == "Down":
			$sprite/anim.play("Idle-Down")
		#$sprite/anim.stop()	
	
func analog_force_change(inForce, inStick):
	if(inStick.get_name()=="AnalogRight") or (inStick.get_name()=="AnalogLeft"):
		if (inForce.length() < 0.1):
			analog_velocity = Vector2(0,0) 
		else:
			analog_velocity = Vector2(inForce.x,-inForce.y)
		
		#Convert analog velocity to 0 , 1 , -1 
		analog_velocity = analog_velocity.normalized()
#		analog_velocity.x = int(round(analog_velocity.x))
#		analog_velocity.y = int(round(analog_velocity.y))
		
		analog_velocity.x = stepify(analog_velocity.x, 1)
		analog_velocity.y = stepify(analog_velocity.y, 1)
#		print(analog_velocity)
		
