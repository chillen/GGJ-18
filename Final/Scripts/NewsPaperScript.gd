extends Control



export(int) var page = 1
export(int) var num_pages = 1
export(String) var  header = "Place Text"
export(String) var  body = "Lorum Lisp "
export(Image) var image

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$Header.text = header
	$Page.text = "%s/%s" % [page,num_pages]
	$Body.text = body
	set_process(true)
	

func _process(delta):
	$BackgroundBody.rect_position = $Body.rect_position
	$BackgroundBody.rect_size = $Body.rect_size


    