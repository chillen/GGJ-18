extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var splatter_class = preload('res://Scenes/Splatter.tscn')
export(Vector2) var velocity = Vector2(0,0)
export(float,0,1) var scalar = 0.8

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$Anime.play('Fall')
	set_process(true)
	#$Anime.connect('animation_finished',
	pass

func _process(delta):
	print(self.position)
	self.position += velocity*delta*scalar

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func splat():
	var splatter = splatter_class.instance()
	get_tree().root().add_child(splatter)
	splatter.position = self.position