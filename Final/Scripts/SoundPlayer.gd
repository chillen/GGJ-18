extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var speech_player = null #= AudioStreamPlayer.new()
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	$Stream.play()

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.#	
	pass