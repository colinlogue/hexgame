extends Polygon2D

export (Color) var BG_COLOR
const PAD = 10

func cover_bg():
	set_color(BG_COLOR)
	var vp_size = get_viewport_rect().size
	var coords = PoolVector2Array()
	coords.append(Vector2(-PAD, -PAD))
	coords.append(Vector2(-PAD, vp_size.y + PAD))
	coords.append(Vector2(vp_size.x + PAD, vp_size.y + PAD))
	coords.append(Vector2(vp_size.x + PAD, -PAD))
	set_position(Vector2(0,0))
	set_polygon(coords)
	z_index = -100