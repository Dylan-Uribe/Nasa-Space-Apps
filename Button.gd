extends Button
@onready var item_list = $"../ItemList"
@onready var file_dialog = $"../../FileDialog"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Ensure the FileDialog is not null before connecting signals
	if file_dialog != null:
		# Connect the button's pressed signal to the _on_button_pressed function
		self.pressed.connect(_on_button_pressed)
		# Connect the file dialog's file_selected signal to the _on_file_selected function
		file_dialog.file_selected.connect(_on_file_selected)
	else:
		print("Error: FileDialog reference is not set.")

# Called when the button is pressed.
func _on_button_pressed():
	# Open the FileDialog to let the user choose a save location
	file_dialog.popup_centered()

# Called when a file is selected in the FileDialog
func _on_file_selected(path: String):
	take_screenshot(path)

# Function to take a screenshot
func take_screenshot(path: String):
	# Hide the button
	item_list.visible=false
	self.visible = false

	# Wait for the frame to finish rendering
	await RenderingServer.frame_post_draw
	
	# Get the viewport texture
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	
	# Save the image to the specified path
	if img.save_png(path):
		print("Screenshot saved to: ", path)
	else:
		print("Failed to save screenshot to: ", path)

	# Show the button again
	self.visible = true
	item_list.visible= true
