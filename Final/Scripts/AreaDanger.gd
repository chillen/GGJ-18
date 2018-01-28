extends Area2D

export(String) var group = ""

signal danger_enter
signal danger_leave

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	GameController.some_function(signal_name,self)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass



func _on_Area_body_entered( body ):
	if body.is_in_group(group):
		print(str('Player has entered'))
		emit_signal('danger_enter')

func _on_Area_body_exited(body):
	if body.is_in_group(group):
		print(str('Player has left'))
		emit_signal('danger_leave')