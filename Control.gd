extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for lop in range(20):
		get_node("ItemList").add_item("star "+str(lop))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
