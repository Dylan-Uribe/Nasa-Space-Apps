extends Node3D

const STARMESH = preload("res://starmesh.tres")
const EXOPLANET = preload("res://exoplanet1.tres")

# Array to store planet locations
var planet_locations: Array = []

# Reference to the ItemList node
@onready var item_list: ItemList = $"Control/ItemList"

# Function to create and add planets to the 3D environment
func create_planet(name: String, position: Vector3, magnitude: float, star_type: String):
	var exoplanet = preload("res://planet.gd").new(name, position, magnitude, star_type)
	add_child(exoplanet)
	
	# Store the planet's position in the array
	planet_locations.append(position)

	# Update the item list with new planet locations
	item_list.populate_with_planet_locations(planet_locations)

# Function to create and add stars to the 3D environment
func create_star(name: String, position: Vector3, magnitude: float, star_type: String):
	var star = preload("res://star.gd").new(name, position, magnitude, star_type)
	add_child(star)

func _ready():
	var star_types = ["A", "B", "F", "G", "K", "O"]  # List of star types
	
	# Create random stars
	for i in range(2000):
		# Generate random position within the range of -1000 to 1000
		var random_position = Vector3(randf_range(-1000, 1000), randf_range(-1000, 1000), randf_range(-1000, 1000))
		# Random magnitude between 1 and 5
		var random_magnitude = randf_range(1, 5)
		# Randomly select a star type
		var random_star_type = star_types[randi() % star_types.size()]
		# Create a star with the random properties
		create_star("Star_%d" % i, random_position, random_magnitude, random_star_type)

	# Create random planets
	for i in range(2000):
		# Generate random position within the range of -1000 to 1000
		var random_position = Vector3(randf_range(-1000, 1000), randf_range(-1000, 1000), randf_range(-1000, 1000))
		# Random magnitude between 0.2 and 0.5
		var random_magnitude = randf_range(0.2, 0.5)
		# Randomly select a star type
		var random_star_type = star_types[randi() % star_types.size()]
		# Create a planet with the random properties
		create_planet("Planet_%d" % i, random_position, random_magnitude, random_star_type)

	# Optional: Print all planet locations
	print("Planet Locations: ", planet_locations)
