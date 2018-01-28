extends Light2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(int) var scale1 = 3.0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization herer
	self.rotation = randf()*360
	self.scale = self.scale*scale1
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
