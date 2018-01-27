extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum {GUI,NOGUI,NEWSPAPER,MISSIONS}

var texts = [
"TERROR FOR THE AVATAR",
"FIRE NATION ATTACKED; EVERYONE SHOCKED",
"HUNDRED YEAR OLD AIRBENDER STILL LOOKS 10! HIS SECRET MAY SHOCK YOU!"
]


var state = GUI
var active_paper = 0
var paper_changed = false


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_text(get_text())
	set_process(true)

func set_text(text):
	$News/Newspaper/MainText.bbcode_text = NewsRelatedData.get_list_newspaper() #text
	
func get_text():
	return texts[active_paper]
	
func next_paper():
	active_paper += 1
	paper_changed = true
	pass
	
func prev_paper():
	#active_paper = (active_paper - 1) % len(texts)
	active_paper = max(0,(active_paper - 1))
	paper_changed = true
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if state == GUI:
		# start news paper Init
		# ...
		# end   news paper Init
		active_paper = 0
		$News.visible = true
		set_text(get_text())
		
		state = NEWSPAPER
	elif state == NEWSPAPER:
		if newspaper_state_machine():
			$News.visible = false
			state = MISSIONS
	elif state == MISSIONS:
		# start mission init
		# ...
		# end mission init
		if true:
			state = NOGUI
	elif state == NOGUI:
		# pull to check when to 
		state = GUI
	print(state)
	
			

func newspaper_state_machine():
	if Input.is_action_just_pressed('next_item'):
		next_paper()
	if Input.is_action_just_pressed('prev_item'):
		prev_paper()
		
	if paper_changed:
		paper_changed = false
		if active_paper < len(texts):
			set_text(texts[active_paper])
		else:
			return true
			#$Newspaper.visible = false
			#$Newspaper.queue_free()
	return false

