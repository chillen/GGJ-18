extends Control


export(Color, RGB) var col = Color(255,255,255) # Color is RGB
export(int) var page = 0
export(int) var num_pages = 0
export(String) var  Header = "Place Text"
export(String) var  Body = "Lorum Lisp"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$News.modulate = col
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
