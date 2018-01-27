extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	pass

func _input(event):
	if GameController.get_state() == GameController.STATES.TITLE:
		if event.get_class() == 'InputEventKey':
			GameController.start_game()

		
func _exit_tree():
	set_process_input(false)
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
