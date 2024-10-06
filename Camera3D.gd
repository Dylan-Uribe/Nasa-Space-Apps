extends Camera3D

@export var aceleracion = 25.0
@export var moveSpeed = 5.0
@export var mousespeed = 300.0
var mouseMode = true

var velocidad = Vector3.ZERO
var lookAngles = Vector2.ZERO

var selected_stars = []
var path: Path3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	path = Path3D.new()
	add_child(path)

func _process(delta):
	lookAngles.y = clamp(lookAngles.y, PI / -2, PI / 2)
	set_rotation(Vector3(lookAngles.y, lookAngles.x, 0))
	var direction = updateDirection()
	
	if direction.length_squared() > 0:
		velocidad += direction * aceleracion * delta
	
	if velocidad.length() > moveSpeed:
		velocidad = velocidad.normalized() * moveSpeed
	
	translate(velocidad * delta)
	if selected_stars.size() == 2:
		drawpath()

func _input(event):
	
	if event is InputEventMouseMotion: 
		if mouseMode == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			lookAngles -= event.relative / mousespeed
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
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
func selectStar():
	var space_state = get_world_3d().direct_space_state
	var ray_origin = global_transform.origin
	var ray_direction = -global_transform.basis.z
	
	var ray_params = {
		"from": ray_origin,
		"to": ray_origin + ray_direction * 100, "exclude": [],
		"collide_with_areas": false, "collide_with_bodies": true
	}
	var result = space_state.intersect_ray(ray_params)
	
	if result and "collider" in result:
		var star = result.collider
		if star is Star:
			if star not in selected_stars:
				selected_stars.append(star)
				star.label.visible = true
				if selected_stars.size() > 2:
					selected_stars.remove(0)

func drawPath():
	path.clear_points()
	path.add_point(selected_stars[0].position)
	path.add_point(selected_stars[1].position)
	var line = MeshInstance3D.new()
	line.mesh = CylinderMesh.new()
	line.material_override=
