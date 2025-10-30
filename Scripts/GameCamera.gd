extends Camera2D

@export var zoom_speed := 0.1
@export var min_zoom := 0.1
@export var max_zoom := 2.0

@onready var player := get_parent().get_node_or_null("Player")

func _ready():
	make_current()
	if player:
		global_position = player.global_position

func _process(_delta: float) -> void:
	if player:
		global_position = player.global_position

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom_in()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom_out()

func zoom_in():
	zoom /= Vector2(1.0 + zoom_speed, 1.0 + zoom_speed)
	zoom.x = clamp(zoom.x, min_zoom, max_zoom)
	zoom.y = clamp(zoom.y, min_zoom, max_zoom)

func zoom_out():
	zoom *= Vector2(1.0 + zoom_speed, 1.0 + zoom_speed)
	zoom.x = clamp(zoom.x, min_zoom, max_zoom)
	zoom.y = clamp(zoom.y, min_zoom, max_zoom)
