extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var active_paper = 0
var paper_changed = false

var texts =  []
var object = []

var child = null

var papers = [
preload('res://Scenes/NewsPaperType1.tscn'), 
preload('res://Scenes/NewsPaperType2.tscn'), 
preload('res://Scenes/NewsPaperType3.tscn'),
preload('res://Scenes/NewsPaperType4.tscn')]



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	
	texts = MissionData.get_tonights_papers()
	renew_papers()
	set_process(true)
	

func generator():
	return papers[floor((len(papers)*randf()))]
	

func renew_papers():
	print("call")
	if not child == null:
		child.queue_free()
	
	var objectClass = generator()
	object = objectClass.instance()
	object.rect_position = self.rect_position
	
	object.header = texts[active_paper].header
	object.body   = texts[active_paper].text
	
	self.add_child(object)
	child = object
	




func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if self.visible == true:
		if Input.is_action_just_pressed('ui_right'):
			print("right")
			active_paper += 1
			if active_paper < len(texts):
				renew_papers()
			pass
			#next_paper()
		if Input.is_action_just_pressed('ui_left'):
			print('left')
			pass
			#prev_paper()
		if active_paper == len(texts):
			print('loop condition')
			GameController.done_reading()
		
		
	
	