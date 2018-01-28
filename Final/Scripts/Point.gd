extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var sprite = null
var location = [0,0]
var loc_name = 'TEST'

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func set_data(name1, location, sprite):
	self.sprite = sprite
	self.location = location
	self.loc_name = name1
	
	position.x = location[0]
	position.y = location[1]
	
	$Icon.texture = sprite

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Point_body_entered( body ):
	print('HI!', self.loc_name)
