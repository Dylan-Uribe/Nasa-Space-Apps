extends ItemList
@onready var camera_3d = $"../../Camera3D"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Optionally, you can clear the list at the start
	clear()

# Method to populate the item list with planet locations
func populate_with_planet_locations(locations: Array):
	# Clear existing items (if necessary)
	clear()

	# Loop through the array and add each location to the ItemList
	for loc in locations:
		# Add the location as a string to the item list
		add_item("Position: %s" % loc)
		
