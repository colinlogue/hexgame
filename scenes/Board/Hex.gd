extends Node2D

signal hex_clicked

export (int) var id
var neighbors = []
const UNCLAIMED_FILL = Color("#FFDD8E")
const UNCLAIMED_OUTLINE = Color("#6A6C91")

var triggered = false

func _ready():
	change_color(UNCLAIMED_FILL, UNCLAIMED_OUTLINE)
	$Label.text = str(id)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func change_color(fill_col, outline_col):
	#
	# Sets the color of the hex.
	#
	# Parameters
	# ----------
	# col : {"red", "green", "white"}
	#     String selector of the color to set the hex to.
	
	$Fill.set_color(fill_col)
	$Outline.set_default_color(outline_col)
	
func scale_collision_area(ratio_vec):
	$TileArea.set_scale(ratio_vec)
	
func set_neighbors():
	pass

func _on_ClickArea_input_event(viewport, event, shape_idx):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("hex_clicked", self)
		
