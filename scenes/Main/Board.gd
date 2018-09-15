extends Node2D

export (PackedScene) var Hex
var hexes = []
const HEX_RATIO = sqrt(0.75)

signal hex_clicked(hex)

func center_board():
	# Moves the board to the center of the viewport.
	var vp_size = get_viewport_rect().size
	position.x = vp_size.x / 2
	position.y = vp_size.y / 2

func set_up_board(n_layers, hex_r, hex_pad, left_margin):
	# Sets up the superhex of tiles that the game is played on.
	#
	# Parameters
	# ----------
	# n_layers : int
	#     Number of layers of the superhex.
	# hex_r : float
	#     Radius of each individual hex tile.
	
	assert(n_layers > 0 and n_layers <= 8)
	center_board()
	position.x += left_margin;
	
	var full_r = hex_r + (hex_pad/2.0)
	var collision_ratio = full_r / hex_r
	var scale_ratio = hex_r / 100.0
	var scale_vec = Vector2(scale_ratio, scale_ratio)
	var hex_id = 0
	for layer in range(n_layers):
		var radius = full_r * layer * 2
		var layer_hexes = []
		for side in range(6):
			# for each side of the new superhex layer, find the corner points and
			# place hexes at equally spaced points on the line between corners
			var angle_start = side * (PI / 3)
			var angle_end = angle_start + (PI / 3)
			var x_start = radius * cos(angle_start)
			var y_start = radius * sin(angle_start)
			var x_end = radius * cos(angle_end)
			var y_end = radius * sin(angle_end)
			var x_len = x_end - x_start
			var y_len = y_end - y_start
			for pt in range(1, layer+1):
				var x_pt = x_start + (pt * (x_len/layer))
				var y_pt = y_start + (pt * (y_len/layer))
				var point_vec = Vector2(x_pt, y_pt)
				layer_hexes.append(point_vec)
		if layer == 0:
			# nothing happens above for layer 0 because range(1, 1) is empty, so we
			# need to add the center hex
			layer_hexes.append(Vector2(0,0))
		for hex_vec in layer_hexes:
			var hex = Hex.instance()
			hex.id = hex_id
			hex_id += 1
			hex.apply_scale(scale_vec)
			hex.scale_collision_area(Vector2(collision_ratio, collision_ratio))
			hex.set_position(hex_vec)
			hex.connect("hex_clicked", self, "_on_hex_clicked")
			add_child(hex)
			hexes.append(hex)

func _on_hex_clicked(hex):
	emit_signal("hex_clicked", hex)
	
func get_hex_by_id(hex_id):
	assert(hexes[hex_id].id == hex_id)
	return hexes[hex_id]
	
func factorial(n):
	var x = 1
	for y in range(n):
		x *= y
	return x