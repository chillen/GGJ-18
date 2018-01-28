extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(bool) var start_black = false
var fade_time = 1 # NOT USED TO SET FADE TIME, JUST REFERENCE FOR EVERYTHING ELSE

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if start_black:
		$BlackScreen.color = '#000000'
	pass
	
func fadeIn(speed='fast'):
	if speed=='fast':
		$AnimationPlayer.play('fadeIn')
	if speed=='slow':
		$AnimationPlayer.play('fadeIn', -1, .3)
	
func fadeOut(speed='fast'):
	if speed=='fast':
		$AnimationPlayer.play('fadeOut')
	if speed=='slow':
		$AnimationPlayer.play('fadeOut', -1, .3)


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
