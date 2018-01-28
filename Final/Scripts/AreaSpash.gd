extends Area2D

export(String) var group_1 = "player"
export(String) var group_2 = "splash"
var splatter_class = preload('res://Scenes/SplatterII.tscn')

signal splash

var mission_id


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
#	GameController.some_function(signal_name,self)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass



func _on_Area_body_entered( body ):
	if body.is_in_group(group_1):
		emit_signal('splash')
		GameController.increase_zone('splash')
	if body.is_in_group(group_2):
		splat()
		GameController.complete_mission(mission_id)

func _on_Area_body_exited(body):
	if body.is_in_group(group_1):
		GameController.decrease_zone('splash')
	if body.is_in_group(group_2):
		pass

func splat():
	var splatter = splatter_class.instance()
	splatter.position = self.global_position
	print(self.global_position)
	print(self.position)
	splatter.scale1 = 7.0
	get_tree().root.add_child(splatter)

	#self.queue_free()