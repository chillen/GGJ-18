extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var active_paper = 0
var paper_changed = false
var texts = ['']

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	renew_papers()
	set_text(get_text())
	set_process(true)

func renew_papers():
	NewsRelatedData.choose_newspaper()
	texts = NewsRelatedData.get_list_newspaper()

func set_text(text):
	$Label.text = texts[active_paper]
	pass
	
func set_arrows():
	if active_paper == 0:
		$LeftArrow.visible = false
	else:
		$LeftArrow.visible = true
	
func get_text():
	return texts[active_paper]
	
func set_page():
	$Page.text = '%s/%s' % [active_paper+1,len(texts)]
	
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
	newspaper_state_machine()
	
			

func newspaper_state_machine():
	
	if Input.is_action_just_pressed('ui_right'):
		next_paper()
	if Input.is_action_just_pressed('ui_left'):
		prev_paper()
	
	set_arrows()
	set_page()
		
	if paper_changed:
		paper_changed = false
		if active_paper < len(texts):
			set_text(texts[active_paper])
		else:
			return true
			#$Newspaper.visible = false
			#$Newspaper.queue_free()
	return false