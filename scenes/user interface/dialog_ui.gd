extends CanvasLayer

signal dialog_started
signal dialog_finished

@export var dialog_lines = [
	"Hi, I'm Windy!", 
	"Welcome to my portfolio house! (Mobile controls are not suppported yet.)",
	"Feel free to look around. You can interact with the laptop.",
	"This portfolio is still under development. More features will be added in the future."
]

@export var text_speed = 0.03	# seconds per letter

var current_line = 0
var typing = false	# letters appearing one by one
var timer = 0.0
var char_index = 0
var full_text = ""
var shown_text = ""
var arrow_tween: Tween

@onready var label = $MarginContainer/Panel/MarginContainer/Label
@onready var arrow = $MarginContainer/Panel/TextureRect

func _ready() -> void:
	# Start immediately when the scene is ready
	start_dialog()
	
func start_dialog():
	current_line = 0
	dialog_started.emit()
	show_line(current_line)
	set_process(true)
	set_process_input(true)

func show_line(index: int):
	full_text = dialog_lines[index]
	typing = true
	char_index = 0
	timer = 0.0
	label.text = ""
	shown_text = ""
	arrow.visible = false
	if arrow_tween:
		arrow_tween.kill() # stop previous tween if any
	show()

func blink_arrow():
	# Fade arrow.modulate.a between 0.2 - 1.0 smoothly every half seconds
	var tween = create_tween().set_loops()
	tween.tween_property(arrow, "modulate:a", 0.2, 0.5)
	tween.tween_property(arrow, "modulate:a", 1.0, 0.5)
	

func _process(delta):
	if typing:
		timer += delta
		if timer >= text_speed:
			timer = 0
			if char_index < full_text.length():
				shown_text += full_text[char_index]
				label.text = shown_text
				char_index += 1
			else:
				typing = false
				arrow.visible = true
				blink_arrow()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("primary action"):
		if typing:
			# Finish typing instantly
			label.text = full_text
			typing = false
			arrow.visible = true
			blink_arrow()
		else:
			# Next line or finish
			current_line += 1
			if current_line >= dialog_lines.size():
				hide()
				dialog_finished.emit()
			else:
				show_line(current_line)
		
