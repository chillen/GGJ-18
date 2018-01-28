extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var timer = null
var once = false

func _ready():
	$Label.text = GameController.days_remaining_text()
	self.timer = Timer.new()
	timer.wait_time = 1
	timer.connect("timeout",self,"_end_timeout") 
	add_child(timer) #to process
	timer.start() #to start 
	
func _end_timeout():
#	GameController.days_remaining_end()

	if self.once:
		self.timer.stop()
		GameController.days_remaining_end()
	else:
		$BlackFader.fadeOut()
		self.once = true
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
