extends Camera3D
const STARMESH = preload("res://starmesh.tres")
@export var aceleracion = 25.0
@export var moveSpeed = 5.0
@export var mousespeed = 300.0
var mouseMode = true
var points:Array
var lines:Array
var mouse_line: MeshInstance3D

var velocidad = Vector3.ZERO
var lookAngles = Vector2.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta):
	lookAngles.y = clamp(lookAngles.y, PI / -2, PI / 2)
	set_rotation(Vector3(lookAngles.y, lookAngles.x, 0))
	var direction = updateDirection()
	
	if direction.length_squared() > 0:
		velocidad += direction * aceleracion * delta
	
	if velocidad.length() > moveSpeed:
		velocidad = velocidad.normalized() * moveSpeed
	
	translate(velocidad * delta)

func _input(event):
	
	if event is InputEventMouseMotion: 
		if mouseMode == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			lookAngles -= event.relative / mousespeed
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			if event.is_action_pressed("select"):
				_draw_point_and_line()
			
	
	# Check for the "release" action to toggle mouse mode
	if event.is_action_pressed("release"):
		if mouseMode == true:
			mouseMode = false  
		else:
			mouseMode = true# Show the mouse cursor



func updateDirection():
	var dir = Vector3()
	
	if Input.is_action_pressed("forward"):
		dir += Vector3.FORWARD
	if Input.is_action_pressed("left"):
		dir += Vector3.LEFT
	if Input.is_action_pressed("right"):
		dir += Vector3.RIGHT
	if Input.is_action_pressed("backward"):
		dir += Vector3.BACK
	if Input.is_action_pressed("up"):
		dir += Vector3.UP
	if Input.is_action_pressed("down"):
		dir += Vector3.DOWN

	if dir == Vector3.ZERO:
		velocidad = Vector3.ZERO
	
	return dir.normalized()
func get_mouse_pos():
	var space_state = get_parent().get_world_3d().get_direct_space_state()
	var mouse_position = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()
	
	var ray_origin = camera.project_ray_origin(mouse_position)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_position) * 1000
	
	var params = PhysicsRayQueryParameters3D.new()
	params.from = ray_origin
	params.to = ray_end
	params.collision_mask = 1
	params.exclude = []
	
	var rayDic = space_state.intersect_ray(params)
	
	if rayDic.has("position"):
		return rayDic ["position"]
	return null
	
func _update_mouse_line():
	if mouse_line == null:
		return  # Exit if mouse_line is not initialized

	var mouse_pos = get_mouse_pos()
	var mouse_line_immediate_mesh = mouse_line.mesh as ImmediateMesh
	if mouse_pos != null and mouse_line_immediate_mesh != null:
		var mouse_pos_V3:Vector3 = mouse_pos
		mouse_line_immediate_mesh.clear_surfaces()
		mouse_line_immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
		mouse_line_immediate_mesh.surface_add_vertex(Vector3.ZERO)
		mouse_line_immediate_mesh.surface_add_vertex(mouse_pos_V3)
		mouse_line_immediate_mesh.surface_end()
func _draw_point_and_line()->void:
	var mouse_pos = get_mouse_pos()
	if mouse_pos != null:
		var mouse_pos_V3:Vector3 = mouse_pos
		
		points.append(await D3d.point(mouse_pos_V3,0.05))
		
		#If there are at least 2 points...
		if points.size() > 1:
			#Draw a line from the position of the last point placed to the position of the second to last point placed
			var point1 = points[points.size()-1]
			var point2 = points[points.size()-2]
			var line = await D3d.line(point1.position, point2.position)
			lines.append(line)

func _clear_points_and_lines()->void:
	for p in points:
		p.queue_free()
	points.clear()
		
	for l in lines:
		l.queue_free()
	lines.clear()
