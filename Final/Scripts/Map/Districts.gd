extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const district_template = preload("res://Scenes/Map/District_Template.tscn")

func _ready():
	var districts = [
		{'title': "Work District", 'xStart': 400, 'yStart':400, 'xEnd': 800, 'yEnd': 800},
		{'title': "Housing District", 'xStart': 400, 'yStart':400, 'xEnd': 800, 'yEnd': 800}
		]
	
	for district in districts:
		var new_district = district_template.instance()
		var shape = new_district.get_node('Shape')
		
		#var rectangle_shape = RectangleShape2D(
		#shape.
		get_parent().add_child(new_district)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
