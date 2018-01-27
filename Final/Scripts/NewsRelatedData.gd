extends Node

var data_texts = [
"TERROR FOR THE AVATAR",
"FIRE NATION ATTACKED; EVERYONE SHOCKED",
"HUNDRED YEAR OLD AIRBENDER STILL LOOKS 10! HIS SECRET MAY SHOCK YOU!"
]

var chosen_texts = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func choose_newspaper():
	# selects new news paper to choose from
	chosen_texts = data_texts
	pass
	
func get_list_newspaper():
	# gets a list of news papers
	return chosen_texts
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
