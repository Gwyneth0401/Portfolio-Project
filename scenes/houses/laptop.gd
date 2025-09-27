extends Area2D

signal menu_opened
signal menu_closed

@onready var player = get_parent().get_node("Player") # adjust path
@export var interaction_distance = 32

func _process(_delta):
	if player.global_position.distance_to(global_position) < interaction_distance:
		$Label.visible = true
		if Input.is_action_just_pressed("interact"):	# Key F
			$LaptopMenu.visible = true
			menu_opened.emit()
	else:
		$Label.visible = false

func _on_laptop_menu_menu_closed() -> void:
	$LaptopMenu.visible = false
	menu_closed.emit()
