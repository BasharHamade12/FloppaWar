extends Label

func _ready():
	# Update the label when the scene starts
	update_kills_label()

func _process(delta):
	# Continuously update the label to reflect the current lives
	update_kills_label()

func update_kills_label():
	# Set the label text to show the current number of Floppa's lives
	text = "Score: %d" % Globals.kills
