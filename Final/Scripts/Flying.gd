extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var missions = []
var mission_nodes = []
var point_class = preload('res://Scenes/Point.tscn')
var splatter_class = preload('res://Scenes/Splatter.tscn')
var package_class = preload('res://Scenes/ThePackage.tscn')
var timer = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.missions = GameController.get_papers()
	
#	for index in missions:
#		var mission_data = GameController.get_paper(index)
#		var title = mission_data.text.title
#		var location = mission_data.mission.loc
#
#		var point = point_class.instance()
#		point.set_data(title, id, location, preload('res://Assets/ParkBenchIcon.png'))
#		add_child(point)
#		move_child(point, 2)
	move_child($Points, 2)
	set_process(true)	
	GameController.connect('end_level', self, '_end_level')
	$Canvas/BlackFaderAll.fadeIn()
	
func _end_level():
	# ANY BIRD WORDS GO HERE
	$Canvas/BlackFader.fadeOut()
	self.timer = Timer.new()
	self.timer.wait_time = 6
	add_child(self.timer)
	self.timer.connect('timeout', self, '_end_level_complete')
	self.timer.start()
	
func _end_level_complete():
	self.timer.stop()
	GameController._leave_level()
	print('done.')
	
func _process(delta):
	$Canvas/AmmoLabel.text = 'Deliveries Available: %s' % GameController.get_ammo()
	$Canvas/TimerLabel.text = 'Till Dusk: %02ds' % GameController.get_level_time()
	$Canvas/SupremeLeader.texture = GameController.get_leader_image()
	
	if GameController.get_leader_message():
		$Canvas/SupremeLabel.text = '"%s"' % GameController.get_leader_message()
		$Canvas/ColorRect.visible = true	
	else:
		$Canvas/SupremeLabel.text = ''
		$Canvas/ColorRect.visible = false	
	

	if Input.is_action_just_pressed('ui_select'):
		var worked = GameController.decrease_ammo()
		if worked:
			var package = package_class.instance()
			package.position = $Player.position
			package.velocity = $Player.player_velocity
			add_child(package)
			GameController.add_package_location(package.position)
			#var splatter = splatter_class.instance()
			#add_child(splatter)
			#splatter.position = $Player.position
