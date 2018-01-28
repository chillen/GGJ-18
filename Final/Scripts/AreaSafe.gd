extends Area2D

export(String) var group = ""

signal safe_enter
signal safe_leave

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
	if body.is_in_group(group):
		GameController.increase_zone('safe')
		emit_signal('safe_enter')

func _on_Area_body_exited(body):
	if body.is_in_group(group):
		GameController.decrease_zone('safe')
		emit_signal('safe_leave')
