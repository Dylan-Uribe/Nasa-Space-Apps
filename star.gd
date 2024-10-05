extends Node3D

# Preload the star mesh resource
const STARMESH = preload("res://starmesh.tres")

# Star attributes
var star_name: String
var coordinates: Vector3

# Optional: Additional attributes like brightness, type, etc.
var magnitude: float
var star_type: String

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
	
	# Optionally, create a label for the star name
	var label = Label3D.new()
	label.text = star_name
	label.position = Vector3(0, 1, 0)  # Position the label above the star
	add_child(label)
	translate(position)
