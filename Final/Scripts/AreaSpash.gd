extends Area2D

export(String) var group_1 = "player"
export(String) var group_2 = "splash"

signal splash


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
		pass

func _on_Area_body_exited(body):
	if body.is_in_group(group_1):
		GameController.decrease_zone('splash')
	if body.is_in_group(group_2):
		pass
