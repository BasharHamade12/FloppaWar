extends CharacterBody2D

var dragging = false
var drag_start = Vector2.ZERO
var start_position = Vector2.ZERO

# Define vertical movement boundaries (adjust these values to fit your screen size)
var min_y_position = 6950  # Top boundary (e.g., top of the screen)
var max_y_position = 7500  # Bottom boundary (e.g., bottom of the screen)

func _ready():
	# Ensure the character starts within the allowed vertical range
	global_position.y = clamp(global_position.y, min_y_position, max_y_position)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				print("Mouse pressed")
				var shape_rid = $CollisionShape2D.shape.get_rid()
				var shape_transform = $CollisionShape2D.global_transform
				var params = PhysicsPointQueryParameters2D.new()
				params.position = get_global_mouse_position()
				params.collision_mask = collision_mask
				var space_state = get_world_2d().direct_space_state
				var result = space_state.intersect_point(params)
				
				if result and result[0].collider == self:
					dragging = true
					drag_start = get_global_mouse_position()
					start_position = global_position
			else:
				dragging = false

func _process(delta):
	if dragging:
		var current_mouse_pos = get_global_mouse_position()
		var drag_delta = current_mouse_pos - drag_start
		
		# Only apply vertical movement, but clamp the y position to stay within the allowed range
		global_position.y = clamp(start_position.y + drag_delta.y, min_y_position, max_y_position)
