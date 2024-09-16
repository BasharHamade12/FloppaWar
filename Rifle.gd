extends Node2D

# Preload the Bullet scene
@export var bullet_scene: PackedScene = preload("res://Bullet.tscn")

# Reference to the Marker2D node where bullets will spawn
@onready var bullet_spawn_point: Marker2D = $BulletSpawnPoint

# Speed at which the bullet will be fired (decrease this value for slower movement)
@export var bullet_speed: float = 2000.0  # Adjust this value for slower speed

# Fire rate (in seconds between shots)
@export var fire_rate: float = 0.2
var time_since_last_shot: float = 0.0

func _process(delta: float) -> void:
	# Update the timer
	time_since_last_shot += delta
	
	# Automatically shoot a bullet when enough time has passed
	if time_since_last_shot >= fire_rate:
		shoot_bullet()
		time_since_last_shot = 0.0

func shoot_bullet() -> void:
	# Instantiate a new bullet from the bullet scene
	var bullet_instance = bullet_scene.instantiate() as RigidBody2D
	
	# Set the bullet's position to the marker's global position (spawn point)
	bullet_instance.global_position = bullet_spawn_point.global_position
	
	# Set the bullet's direction and speed
	bullet_instance.linear_velocity = Vector2(bullet_speed, 0)  # Directly forward with no rotation
	
	# Add the bullet to the scene
	get_tree().root.add_child(bullet_instance)
	
	# Optionally, play a shooting sound or animation here
	# Example: $ShootSound.play()
