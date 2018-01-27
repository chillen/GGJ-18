extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var paper_data = [
	{'text': {'title': 'BIRD FLU EPIDEMIC', 'content': 'Doctors still unsure...'}, 'mission': { 'loc': [50, 900], 'stats': {'suspicion': .8, 'support': .1, 'unrest': .9 }}},
	{'text': {'title': 'IS LOREM IPSUM ON ITS WAY OUT?', 'content': 'More at 11...'}, 'mission': { 'loc': [100, 200], 'stats': {'suspicion': .5, 'support': .3, 'unrest': .4 } } },
	{'text': {'title': 'UNREGISTERED HYPERCAM', 'content': '2006 Youtube at its finest'}, 'mission': { 'loc': [200, 300], 'stats': {'suspicion': .1, 'support': .8, 'unrest': .2 } }}	
]

enum STATES {START_DAY, DAY, START_TITLE, TITLE, STOP_TITLE, START_FLYING,FLYING,END_FLYING, START_READING, READING, END_READING, START_MISSIONS, MISSIONS, END_MISSION, START_WAYPOINT, WAYPOINT, END_WAYPOINT}
var selected_paper = 0	
var on_continue = false
var active_state_process = null
var active_state = null
var possible_missions = [0, 2]
var selected_missions = [false, false]
var mission_performance = {}
var performance_history = []
var current_scene = null
var days_remaining = 7
var timer = null
var ammo = 7


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
#	print('hi')
	change_state(START_TITLE, 'title_state')
	set_process(true)
	
func _process(delta):
	active_state_process.call_func()
	
func change_state(state_name, state_func_name):
	self.active_state = state_name
	self.active_state_process = funcref(self, state_func_name)
	
func get_state():
	return self.active_state
	
##########################################################################
##	DATA SELECTORS
##########################################################################

func increment_selected():
	selected_paper += 1
	if on_continue:
		on_continue = false
		selected_paper = 0
	on_continue = selected_paper >= len(possible_missions)
	if not on_continue:
		var selected_ind = possible_missions[selected_paper]
		return paper_data[selected_ind]
	else:
		return false
	
func decrement_selected():
	selected_paper -= 1
	if on_continue:
		on_continue = false
		selected_paper = len(possible_missions) - 1
	on_continue = selected_paper < 0
	if not on_continue:
		var selected_ind = possible_missions[selected_paper]
		return paper_data[selected_ind]
	else:
		return false
		
func select():
	if on_continue:
		# Appropriate state transition
		return
	selected_missions[selected_paper] = !selected_missions[selected_paper]
	
func get_paper(index):
	var real_index = possible_missions[index]
	return paper_data[real_index]
	
func is_selected(index):
	return selected_missions[index]

func get_papers():
	return range(0, len(possible_missions))
	
func start_game():
	change_state(START_DAY, 'day_state')
	
func days_remaining_text():
	if days_remaining == 0:
		return "The final day"
	else:
		return "%s days remain" % days_remaining
		
func get_ammo():
	return self.ammo
	
func decrease_ammo():
	self.ammo -= 1
	
#############################################################################
## 	STATES
#############################################################################
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	if current_scene != null:
		current_scene.queue_free()
	# Load new scene
	var s = ResourceLoader.load(path)
	
	# Instance the new scene
	self.current_scene = s.instance()
	
	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)
	
	# optional, to make it compatible with the SceneTree.change_scene() API
	get_tree().set_current_scene( current_scene )
	
func title_state():
	if active_state == START_TITLE:
		goto_scene("res://Scenes/TitleScreen.tscn")
		self.active_state = TITLE
	
func day_state():
	if active_state == START_DAY:
		goto_scene("res://Scenes/DaysRemaining.tscn")
		self.active_state = DAY

		self.timer = Timer.new()
		timer.wait_time = 3
		timer.connect("timeout",self,"_end_timeout") 
		add_child(timer) #to process
		timer.start() #to start
		
func _end_timeout():
	change_state(START_FLYING, 'flying_state')
	self.timer.stop()
	
func flying_state():
	if active_state == START_FLYING:
		goto_scene("res://Scenes/Map/Map.tscn")
		self.active_state = FLYING
		self.ammo = 7
	
func reading_state():
	return

func planning_state():
	return
	
func waypoint_state():
	return