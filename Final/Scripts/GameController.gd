extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal end_level

var paper_data = [
	{'text': {'title': 'BIRD FLU EPIDEMIC', 'content': 'Doctors still unsure...'}, 'mission': { 'loc': [50, 900], 'stats': {'suspicion': .8, 'support': .1, 'unrest': .9 }}},
	{'text': {'title': 'IS LOREM IPSUM ON ITS WAY OUT?', 'content': 'More at 11...'}, 'mission': { 'loc': [100, 200], 'stats': {'suspicion': .5, 'support': .3, 'unrest': .4 } } },
	{'text': {'title': 'UNREGISTERED HYPERCAM', 'content': '2006 Youtube at its finest'}, 'mission': { 'loc': [200, 300], 'stats': {'suspicion': .1, 'support': .8, 'unrest': .2 } }}	
]

var leader_messages = {
	'splash': '',
	'safe': '',
	'danger': 'Turn back, birdrov, there is no friends there',
	'failed': 'I am disappointed you have strayed, birdov',
	'tut1': 'Press <SPACE> to deliver the first package, birdrov'
}

enum STATES {START_ENDING, ENDING, END_ENDING, START_DAY, DAY, START_TITLE, TITLE, STOP_TITLE, START_FLYING,FLYING,END_FLYING, START_READING, READING, END_READING, START_MISSIONS, MISSIONS, END_MISSION, START_WAYPOINT, WAYPOINT, END_WAYPOINT}
var selected_paper = 0	
var on_continue = false
var active_state_process = null
var active_state = null
var possible_missions = [0, 2]
var selected_missions = [false, false]
var mission_performance = {}
var performance_history = []
var current_scene = null
var timer = null
var ammo = 7
var current_leader_message = 'tut1'
var zone_counts = {'safe': 0, 'danger': 0, 'splash': 0}
var leader_sprites = {
	'kawaii': preload('res://Assets/StalinPidgeon_Kawaii.png'),
	'dontfuckup': preload('res://Assets/StalinPidgeon_DontFuckUpComrade.png'),
	'neutral': preload('res://Assets/StalinPidgeon_Neutral.png')
}
var current_leader_image = 'neutral'
var level_timer = null
var audio_streamer = null


var package_locations = []
var completed_missions = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
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
	var days_remaining = (len(MissionData.day_missions) - MissionData.current_day)
	if days_remaining == 0:
		return "The final day"
	else:
		return "%s days remain" % days_remaining
		
func get_ammo():
	return self.ammo
	
func decrease_ammo():
	if self.ammo == 0:
		return false
	self.ammo -= 1
	return true

func get_leader_message():
	return leader_messages[self.current_leader_message]

func get_leader_image():
	return leader_sprites[current_leader_image]

func update_leader_message():
	if zone_counts['splash'] > 0:
		current_leader_message = 'splash'
		current_leader_image = 'kawaii'
	elif zone_counts['safe'] > 0:
		current_leader_message = 'safe'
		current_leader_image = 'neutral'
	elif zone_counts['danger'] > 0:
		current_leader_message = 'danger'
		current_leader_image = 'dontfuckup'
	else:
		current_leader_message = 'failed'	
		current_leader_image = 'dontfuckup'
	
func increase_zone(zone):
	self.zone_counts[zone] += 1

func decrease_zone(zone):
	self.zone_counts[zone] -= 1
	
func get_level_time():
	return self.level_timer.time_left
	
func add_package_location(location):
	package_locations.append(location)
	
func complete_mission(id):
	MissionData.completed_missions.append(id)

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
		
func days_remaining_end():
	self.active_state = START_FLYING
	change_state(START_FLYING, 'flying_state')
	
func _end_level():
	self.level_timer.stop()
	emit_signal('end_level')
	self.active_state = END_FLYING

func _leave_level():
	change_state(START_READING, 'reading_state')
	
func flying_state():
	if active_state == START_FLYING:
		goto_scene("res://Scenes/Map.tscn")
		self.active_state = FLYING
		self.ammo = 7
		self.level_timer = Timer.new()
		self.level_timer.connect("timeout",self,"_end_level") 
		add_child(self.level_timer)
		self.level_timer.wait_time = 45
		self.level_timer.start()
	if active_state == FLYING:
		update_leader_message()
		if self.ammo == 0:
			_end_level()

	
func reading_state():
	if active_state == START_READING:
		goto_scene("res://Scenes/Reading.tscn")
		self.active_state = READING

func done_reading():
	if active_state == READING:
		self.active_state = END_READING
		change_state(START_DAY,'day_state')
		#days_remaining -= 1
		print('done_reading')
		print(MissionData.next_day())
	
func planning_state():
	return
	
func waypoint_state():
	return
	
func game_over():
	print('GAME IS OVER!')
	change_state(START_ENDING, 'ending_state')

func ending_state():
	if active_state == START_ENDING:
		goto_scene("res://Scenes/Ending.tscn")
		self.active_state = ENDING
	MissionData.end()