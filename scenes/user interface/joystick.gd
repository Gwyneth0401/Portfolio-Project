extends Control

var dragging = false
var direction = Vector2.ZERO
var max_distance = 60
var knob_initial_position = Vector2.ZERO

func _ready():
	# Store initial position (centered)
	knob_initial_position = $Base/Knob.position

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		# Start drag if touch inside Base
		if event.pressed and $Base.get_global_rect().has_point(event.position):
			dragging = true
		elif not event.pressed:
			dragging = false
			direction = Vector2.ZERO
			# Reset knob to center
			$Base/Knob.position = knob_initial_position
			
	elif event is InputEventScreenDrag and dragging:
		# Convert touch to local Base coordinates
		var local_touch = $Base.to_local(event.position)
		var center = $Base.size / 2
		var knob_offset = local_touch - center

		# Limit knob movement
		if knob_offset.length() > max_distance:
			knob_offset = knob_offset.normalized() * max_distance

		$Base/Knob.position = knob_initial_position + knob_offset
		direction = knob_offset / max_distance  # normalized -1 to 1
