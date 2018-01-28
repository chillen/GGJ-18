extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var missions = []
var mission_nodes = []
var point_class = preload('res://Scenes/Point.tscn')
var splatter_class = preload('res://Scenes/Map/Splatter.tscn')

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.missions = GameController.get_papers()
	
	for index in missions:
		var mission_data = GameController.get_paper(index)
		var title = mission_data.text.title
		var location = mission_data.mission.loc

		var point = point_class.instance()
		point.set_data(title, location, preload('res://Scenes/White.png'))
		add_child(point)
		move_child(point, 3)
		
	set_process(true)	
	
	
func _process(delta):
	$Canvas/Label.text = 'Deliveries Available: %s' % GameController.get_ammo()
	if Input.is_action_just_pressed('ui_select'):
		var worked = GameController.decrease_ammo()
		if worked:
			var splatter = splatter_class.instance()
			add_child(splatter)
			splatter.position = $Player.position
