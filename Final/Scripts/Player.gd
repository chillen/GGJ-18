extends KinematicBody2D

var turn_velocity = 0
var velocity_multiplier = 3
var base_speed = 0.1
var max_turn_speed = 0.08
var player_velocity = Vector2(0, 0)

var map_size

export(float,0,10,0.5) var temp_speed = 5
var max_box = {}
var flapping = true

func _ready():
	self.position.x = 800
	self.position.y = 800
	self.add_to_group('player')
	var topleft = get_parent().get_node('Mapmap').get_node('Topleft')
	var bottomright = get_parent().get_node('Mapmap').get_node('Bottomright')
	self.max_box = {
		'minx': topleft.position.x,
		'miny': topleft.position.y, 
		'maxx': bottomright.position.x, 
		'maxy': bottomright.position.y
	}

	$Camera.limit_left = self.max_box.minx*3
	$Camera.limit_top = self.max_box.miny*3
	$Camera.limit_right = self.max_box.maxx*3
	$Camera.limit_bottom = self.max_box.maxy*3
	


func _physics_process(delta):
	if turn_velocity > 0:
		turn_velocity -= min(0.4 * delta, turn_velocity * delta * 60)
	elif turn_velocity < 0:
		turn_velocity += min(0.4 * delta, turn_velocity * -1 * delta * 60)
		
	if Input.is_action_pressed("ui_a"):
		turn_velocity -= 1.4 * delta
		if flapping:
			flapping = false
			$AnimationPlayer.play('Soaring')
	elif Input.is_action_pressed("ui_d"):
		turn_velocity += 1.4 * delta
		if flapping:
			flapping = false
			$AnimationPlayer.play('Soaring')
	else:
		if not flapping:
			flapping = true
			$AnimationPlayer.play('Flapping')
	
	if turn_velocity > max_turn_speed:
		turn_velocity = max_turn_speed
	elif turn_velocity < -max_turn_speed:
		turn_velocity = -max_turn_speed
		
	velocity_multiplier = (1 + (1 * (pow(abs(turn_velocity * 3), 1)))) * delta * 60
	
	self.rotation += turn_velocity
	
	player_velocity.x = (cos(self.rotation - 1.57)) * velocity_multiplier * delta * 250
	player_velocity.y = (sin(self.rotation - 1.57)) * velocity_multiplier * delta * 250
	

	self.position.x += player_velocity.x
	self.position.y += player_velocity.y
	
	if (abs(self.position.x) > map_size.x / 2 - 300 or abs(self.position.y) > map_size.y / 2 - 300):
		self.rotation += PI