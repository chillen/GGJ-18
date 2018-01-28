extends Node2D

var text_queue = []
var text_timer
var is_showing_text = false

func _ready():
	#SupremeLeader.connect('next_text', self, '_next_text')
	#SupremeLeader.connect('next_text', self, '_next_text')
	$Sprite.texture = GameController.get_leader_image()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func queue_message(string, time):
	text_queue.append([string, time])
	if (is_showing_text == false):
		next_text()
	
func next_text():
	if (text_queue.size() > 0):
		is_showing_text = true
		$ColorRect.visible = true
		$Label.visible = true
		
		var message = text_queue.front()
		text_queue.pop_front()

		$Label.text = '"%s"' % message[0]

		self.text_timer = Timer.new()
		self.text_timer.connect("timeout",self,"next_text") 
		add_child(self.text_timer)
		self.text_timer.wait_time = message[1]
		self.text_timer.start()
	else:
		is_showing_text = false
		$ColorRect.visible = false
		$Label.visible = false