extends Label

func _ready():
	# Update the label when the scene starts
	update_lives_label()

func _process(delta):
	# Continuously update the label to reflect the current lives
	update_lives_label()

func update_lives_label():
	# Set the label text to show the current number of Floppa's lives
	text = "Floppa Lives: %d" % Globals.floppa_lives
