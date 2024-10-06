extends Node2D

# Store points clicked by the user
var points: Array = []
var line: Line2D

func _ready():
	# Initialize Line2D node for drawing lines
	line = Line2D.new()
	add_child(line)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var click_position = event.position
		points.append(click_position)
		draw_point(click_position)

		# If two points are clicked, draw a line between them
		if points.size() == 2:
			draw_custom_line(points[0], points[1])
			points.clear()  # Clear points for the next line
	if event.is_action_pressed("release"):
		line.clear_points()
func draw_point(position: Vector2):
	# Create a point as a circle
	var point = CircleShape2D.new()
	point.radius = 5  # Adjust size as needed
	var point_shape = CollisionShape2D.new()
	point_shape.shape = point
	point_shape.position = position
	add_child(point_shape)

func draw_custom_line(start: Vector2, end: Vector2):
	  # Clear any existing points
	line.add_point(start)
	line.add_point(end)
	line.default_color = Color(1, 1, 1)  # Red color for the line
	line.width = 2  # Adjust line width as needed

