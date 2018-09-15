extends Node

export (int) var HEX_PADDING
export (int) var VP_PADDING
export (int) var N_LAYERS
export (int) var LEFT_MARGIN

var players
var num_players

var active_player

func _ready():
	$Background.cover_bg()
	$Board.set_up_board(N_LAYERS, calc_hex_radius(), HEX_PADDING, LEFT_MARGIN)
	players = [$Player1, $Player2]
	num_players = players.size()
	active_player = $Player1

func calc_hex_radius():
	var x_size = get_viewport().get_visible_rect().size.x
	x_size -= (2*VP_PADDING) # subtract padding for each side of the viewport
	x_size -= (2 * (N_LAYERS-1)) # subtract padding between each hex
	x_size /= 2
	x_size /= ((2*N_LAYERS) - 1)
	return x_size

func action_plant(hex):
	# Plant a seed node on a hex that will grow to adjacent open hexes
	# with the Grow action. The hex will provide a point on a Harvest action.
	pass

func action_claim(hex1, hex2):
	# Places claim nodes on two hexes (three?) that mark the hex for the
	# player but will not grow on a Grow action. They will provide points
	# on a Harvest action.
	pass

func action_grow():
	# Places a seed node on all hexes adjacent to where the player currently
	# has seed nodes.
	pass

func action_harvest():
	# Gives the player one point per controlled hex any hex with a claim node or
	# a seed node on it).
	pass

func _input(event):
	if event.is_action_pressed("ui_left"):
		active_player = $Player1
	elif event.is_action_pressed("ui_right"):
		active_player = $Player2

func _on_Board_hex_clicked(hex):
	active_player._on_hex_selection(hex)
	
func display_message(code, message):
	print(message)
	$MessagePopup/MessageLabel.text = message
	$MessagePopup.popup()
