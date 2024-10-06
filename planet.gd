extends Node3D

# Preload the star mesh resource
const STARMESH = preload("res://exoplanet1.tres")

# Star attributes
var star_name: String
var coordinates: Vector3

# Optional: Additional attributes like brightness, type, etc.
var magnitude: float
var star_type: String

# Declare a variable to hold a reference to the label
var label: Label3D

# Initialize the star with attributes
func _init(name: String, position: Vector3, magnitude: float = 1.0, star_type: String = "G"):
	star_name = name
	coordinates = position
	self.magnitude = magnitude
	self.star_type = star_type

	# Use the preloaded star mesh (STARMESH)
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = SphereMesh.new()
	mesh_instance.material_override = STARMESH
	mesh_instance.scale = Vector3(magnitude, magnitude, magnitude)  # Scale the mesh based on the star's magnitude
	add_child(mesh_instance)

	# Add a StaticBody3D for collision
	var static_body = StaticBody3D.new()
	add_child(static_body)

	# Add a CollisionShape3D to the StaticBody3D
	var collision_shape = CollisionShape3D.new()
	var sphere_shape = SphereShape3D.new()
	sphere_shape.radius = magnitude  # Set the radius based on the star's magnitude
	collision_shape.shape = sphere_shape
	static_body.add_child(collision_shape)

	# Optionally, create a label for the star name
	label = Label3D.new()
	label.text = star_name
	label.position = Vector3(0, magnitude, 0)  # Position the label above the star
	add_child(label)
	
	label = Label3D.new()
	label.text = star_type
	label.position = Vector3(0, magnitude + 1, 0)  # Position the label above the star
	add_child(label)

	translate(position)

func _process(delta):
	# Get the camera node in the current scene
	var camera = get_tree().current_scene.get_node("Camera3D")  # Adjust the path based on your scene structure
	if camera:
		# Calculate the direction from the label to the camera
		var direction = (camera.position - label.position).normalized()
		
		# Make the label look at the camera position
		label.look_at(camera.position)
		
		# Optional: Adjust for the label orientation
		label.rotation_degrees.y += 180  # Adjust the Y rotation to face the camera correctly

