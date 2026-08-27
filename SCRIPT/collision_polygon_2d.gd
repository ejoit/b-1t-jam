extends CollisionPolygon2D

@export var show = true
@export var color: Color = Color(Color.GREEN, 0.3)




func _draw() -> void:
	if not show: return
	
	var points = get_polygon()
	draw_colored_polygon(points, color)

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func change_color(newColor):
	color = newColor
	queue_redraw()
