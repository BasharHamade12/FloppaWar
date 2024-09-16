extends Node2D

@export var scroll_speed: float = 200.0
@export var bingus_speed: float = 400.0  # Speed of Bingus, making it move faster to the left
@export var background_width: float = 2808.0
@export var spawn_interval: float = 0.5
@export var bingus_count: int = 0  # Number of Bingus enemies to spawn initially
@export var bingus_scene: PackedScene = preload("res://Bingus.tscn")  # Preload the Bingus scene
@export var activation_distance_x: float = 200.0  # X-Distance for Bingus collider to activate

var time_since_last_spawn: float = 0.0

func _ready() -> void:
	$Background1.position.x = 0.0
	
	# Dynamically duplicate the background initially
	for i in range(4):
		spawn_new_background()

	# Spawn initial Bingus enemies
	for i in range(bingus_count):
		spawn_bingus()

func _process(delta: float) -> void:
	# Move all background instances to the left
	for child in get_children():
		if child is Node2D and child != $Camera2D and child != $Floppa:
			child.position.x -= scroll_speed * delta
			
			# Move Bingus to the left at a faster speed
			if child.name.begins_with("Bingus"): 
				child.position.x -= bingus_speed * delta
				
				# Compare only the X distance between Bingus and Floppa
				var x_distance_to_floppa = abs($Floppa.position.x - child.position.x)
				
				
				# Access the Area2D through the child node structure
				var bingus_children = child.get_children()
				
				

	time_since_last_spawn += delta
	if time_since_last_spawn >= spawn_interval:
		spawn_new_background()
		time_since_last_spawn = 0.0

	for child in get_children():
		# Check if the child is not a CanvasLayer and meets the other conditions
		if not child is CanvasLayer and child.position.x <= -background_width and child != $Camera2D and child != $Floppa and !child.name.begins_with("Bingus"):
			queue_free_background(child)


func spawn_new_background() -> void:
	var new_background = $Background1.duplicate()  # Duplicate the Background1 node
	var last_background = get_last_background_node()  # Get the last background instance
	new_background.position.x = last_background.position.x + background_width  # Position it after the last background
	add_child(new_background)  # Add the new background as a child of InfiniteScroller

	# Optionally, spawn more Bingus enemies when a new background is added
	spawn_bingus() 
	
	

func queue_free_background(background: Node2D) -> void:
	if background.name != "Background1":
		background.queue_free()

func get_last_background_node() -> Node2D:
	var last_background: Node2D = null
	for child in get_children():
		if child is Node2D and child != $Camera2D and child != $Floppa and !child.name.begins_with("Bingus"):
			if last_background == null or child.position.x > last_background.position.x:
				last_background = child
	return last_background

func spawn_bingus() -> void:
	var bingus_instance = bingus_scene.instantiate()  # Create an instance of Bingus
	var background_position = get_last_background_node().position  # Get position of the last background

	# Set Bingus initial position within the defined range
	bingus_instance.position = Vector2(
		-2977,  
		randf_range(-400, 100)    # Random Y position between -450 and 100
	)
	bingus_instance.name = "Bingus_" + str(get_child_count())	
	add_child(bingus_instance)  # Add Bingus to the scene
