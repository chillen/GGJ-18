extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.position.x = 800
	self.position.y = 800
	self.add_to_group('player')

func _process(delta):	
	if Input.is_action_pressed("ui_a"):
		self.rotation -= 0.05
	if Input.is_action_pressed("ui_d"):
		self.rotation += 0.05
		
	self.position.x += cos(self.rotation - 1.57)
	self.position.y += sin(self.rotation - 1.57)