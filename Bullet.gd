extends RigidBody2D

func _on_area_2d_area_entered(area): 
	if area.is_in_group("bingus_group"):
		var bingus_root = area.get_parent()  # Get the parent of the area, which should be the Bingus node
		if bingus_root:
			bingus_root.queue_free()  # Destroy the entire Bingus  object
			Globals.kills += 1
	elif area.is_in_group("floppa_group"):
		var floppa_root = area.get_parent()  # Get the parent of the area, which should be the Floppa node
		if floppa_root:
			# Access and modify the global lives variable
			Globals.floppa_lives -= 1
			print("Floppa hit! Lives remaining: %d" % Globals.floppa_lives)
			
			if Globals.floppa_lives <= 0:
				print("Floppa is dead! Restarting scene...")
				# Restart the current scene 
				Globals.floppa_lives = 9  
				Globals.kills = 0
				var current_scene = get_tree().current_scene
				get_tree().reload_current_scene()
