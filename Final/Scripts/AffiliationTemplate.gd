extends Node2D

export(int) var mission_id

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$Splash/Area.mission_id = mission_id

func set_sprite(texture):
	$Sprite.texture = texture

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
