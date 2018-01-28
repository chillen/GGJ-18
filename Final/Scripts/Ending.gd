extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$Canvas/BlackFader.fadeIn('slow')
	var ending = MissionData.ending
	
	if ending == 'blue':
		$Canvas/BlueWin.visible = true
	else:
		$Canvas/RedWin.visible = true
	$Canvas/Credits/AnimationPlayer.play("Roll")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
