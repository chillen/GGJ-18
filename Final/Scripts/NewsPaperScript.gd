extends Control


export(Color, RGB) var col = Color(255,255,255) # Color is RGB
export(int) var page = 0
export(int) var num_pages = 0
export(String) var  header = "Place Text"
export(String) var  body = "Lorum Lisp"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$News.modulate = col
	$Header.text = header
	$Page.text = "%s/%s" % [page,num_pages]
	$Body.text = body
	$Background.rect_size = $Body.rect_size

	pass
