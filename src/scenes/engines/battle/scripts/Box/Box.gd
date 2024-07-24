extends StaticBody2D

func _process(delta):
	tick_box()

func tick_box():
	$Outlines.points = $Lines.points
	$Back.polygon = $Lines.points
	
	var line_poly = Geometry2D.offset_polyline($Lines.points, $Lines.width / 2, Geometry2D.JOIN_SQUARE, Geometry2D.END_SQUARE)
	$Collision.polygon = line_poly[0]
	var last_line_poly = Geometry2D.offset_polyline([$Lines.points[-1], $Lines.points[0]], $Lines.width / 2, Geometry2D.JOIN_SQUARE, Geometry2D.END_SQUARE)
	$Collision2.polygon = last_line_poly[0]
