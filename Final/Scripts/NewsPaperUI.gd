extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var active_paper = 0
var paper_changed = false

var texts =  []
var object = []

var papers = [
preload('res://Scenes/NewsPaperType1.tscn'), 
preload('res://Scenes/NewsPaperType2.tscn'), 
preload('res://Scenes/NewsPaperType3.tscn'),
preload('res://Scenes/NewsPaperType4.tscn')]


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	renew_papers()
	set_process(true)

func generator():
	return papers[floor((len(papers)*randf()))]
	

func renew_papers():
	
	var objectClass = generator()
	object = objectClass.instance()
	object.rect_position = self.rect_position
	#print($ColorRect.rect_position)
	object.header = "THE EMPIRE STRIKES BACK"
	object.body   = "PUG"
	self.add_child(object)
	




func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if Input.is_action_just_pressed('ui_right'):
		pass
		#next_paper()
	if Input.is_action_just_pressed('ui_left'):
		pass
		#prev_paper()
	
	