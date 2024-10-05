extends Node3D
# Function to create and add stars to the 3D environment
func create_star(name: String, position: Vector3, magnitude: float, star_type: String):
	var star = preload("res://star.gd").new(name, position, magnitude, star_type)
	add_child(star)

func _ready():
	# Example: Adding stars
	create_star("Star Alpha", Vector3(0, 0, 1), 1.0, "G")
