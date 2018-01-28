extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var timer = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	_start_timer()
	$CanvasLayer/BlackFader.fadeIn()
	

func _start_timer():
	# ANY BIRD WORDS GO HERE
	self.timer = Timer.new()
	self.timer.wait_time = 6
	add_child(self.timer)
	self.timer.connect('timeout', self, '_end_timer')
	self.timer.start()
	$CanvasLayer/UI.visible = false
	
func _end_timer():
	self.timer.stop()
	$CanvasLayer/UI.visible = true
	self.visible = false

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
