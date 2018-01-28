extends KinematicBody2D

var turn_velocity = 0
var velocity_multiplier = 3
var base_speed = 0.1
export(float,0,10,0.5) var temp_speed = 5
var max_box = {}

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

func _process(delta):
	if turn_velocity > 0:
		turn_velocity -= min(0.01, turn_velocity)
	elif turn_velocity < 0:
		turn_velocity += min(0.01, turn_velocity * -1)
		
	if Input.is_action_pressed("ui_a"):
		turn_velocity -= 0.015
	if Input.is_action_pressed("ui_d"):
		turn_velocity += 0.015
	
	if turn_velocity > 0.05:
		turn_velocity = 0.05
	elif turn_velocity < -0.05:
		turn_velocity = -0.05
		
	velocity_multiplier = 1 - pow(0.05 - abs(turn_velocity), 2)
	
	self.rotation += turn_velocity
		
	self.position.x += cos(self.rotation - 1.57) * temp_speed
	self.position.y += sin(self.rotation - 1.57) * temp_speed