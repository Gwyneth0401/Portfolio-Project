extends CanvasLayer

signal menu_closed

@onready var left_choices = $MenuPanel/VBoxContainer/TopSection/LeftChoices
@onready var description_label = $MenuPanel/VBoxContainer/BottomSection/MarginContainer/Label

var options = [
	{"name": "Resume", "desc": "Learn more about me from my resume"},
	{"name": "Exit", "desc": "Close the laptop and return to the room"}
]

var current_index = 0

func _ready():
	# Create menu buttons dynamically
	for i in options.size():
		var btn = Button.new()
		btn.text = options[i].name
		btn.size_flags_horizontal = Control.SIZE_FILL
		btn.size_flags_vertical = Control.SIZE_EXPAND_FILL
		btn.focus_mode = Control.FOCUS_ALL
		btn.mouse_filter = Control.MOUSE_FILTER_PASS
		btn.connect("pressed", Callable(self, "_on_option_selected").bind(i))
		btn.connect("mouse_entered", Callable(self, "_on_option_hovered").bind(i))
		left_choices.add_child(btn)
	
	# Hightlight the first option
	_update_selection(0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down") and current_index != options.size() - 1:
		current_index += 1
		_update_selection(current_index)
	elif event.is_action_pressed("ui_up") and current_index != 0:
		current_index -= 1
		_update_selection(current_index)
	elif event.is_action_pressed("ui_accept"):
		_on_option_selected(current_index)

func _update_selection(index: int) -> void:
	current_index = index
	
	for i in range(options.size()):
		var btn = left_choices.get_child(i)
		btn.release_focus()

	# Hightlight current button
	var active_btn = left_choices.get_child(current_index)
	active_btn.grab_focus()

	# Update description
	description_label.text = options[current_index].desc

func _on_option_selected(index: int) -> void:
	match options[index].name:
		"Resume":
			print("Open resume") 
		"Exit":
			menu_closed.emit()

func _on_option_hovered(index: int):
	_update_selection(index)
