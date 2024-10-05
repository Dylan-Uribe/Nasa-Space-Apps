extends Node3D
const STARMESH = preload("res://starmesh.tres")
# Function to create and add stars to the 3D environment
func create_star(name: String, position: Vector3, magnitude: float, star_type: String):
	var star = preload("res://star.gd").new(name, position, magnitude, star_type)
	add_child(star)

func _ready():
	# Example: Adding stars
		create_star("Star 1", Vector3(-15, 72, 67), 5, "A")
		create_star("Star 2", Vector3(-21, -44, 4), 2, "B")
		create_star("Star 3", Vector3(-51, 84, -64), 5, "G")
		create_star("Star 4", Vector3(-84, -25, 98), 4, "G")
		create_star("Star 5", Vector3(-78, 86, -93), 4, "F")
		create_star("Star 6", Vector3(-70, -65, 11), 3, "A")
		create_star("Star 7", Vector3(3, 40, -12), 1, "G")
		create_star("Star 8", Vector3(97, -53, -51), 5, "B")
		create_star("Star 9", Vector3(-84, -74, 83), 1, "O")
		create_star("Star 10", Vector3(68, -44, -38), 4, "F")
		create_star("Star 11", Vector3(89, 6, 41), 5, "K")
		create_star("Star 12", Vector3(81, -46, -47), 1, "O")
		create_star("Star 13", Vector3(99, -3, -51), 3, "K")
		create_star("Star 14", Vector3(36, -97, -19), 1, "A")
		create_star("Star 15", Vector3(-10, 29, 2), 3, "O")
		create_star("Star 16", Vector3(-68, -26, -93), 1, "F")
		create_star("Star 17", Vector3(10, -37, -34), 2, "F")
		create_star("Star 18", Vector3(-71, 95, 25), 1, "G")
		create_star("Star 19", Vector3(80, -70, 42), 1, "K")
		create_star("Star 20", Vector3(27, -89, -20), 5, "O")
		create_star("Star 21", Vector3(71, 1, -14), 1, "A")
		create_star("Star 22", Vector3(6, 94, -97), 4, "K")
		create_star("Star 23", Vector3(-86, -67, 90), 3, "A")
		create_star("Star 24", Vector3(93, 63, 24), 2, "G")
		create_star("Star 25", Vector3(70, 61, 78), 1, "F")
		create_star("Star 26", Vector3(52, 49, -37), 5, "B")
		create_star("Star 27", Vector3(-67, -99, -19), 5, "F")
		create_star("Star 28", Vector3(12, -68, -81), 2, "B")
		create_star("Star 29", Vector3(63, -3, 86), 4, "K")
		create_star("Star 30", Vector3(-29, -84, -43), 1, "O")


