extends Node2D

@onready var is_mobile = OS.get_name() in ["Andriod", "iOS"]

func _on_dialog_box_dialog_started() -> void:
	$Player.can_move = false
	$MobileControls.visible = false

func _on_dialog_box_dialog_finished() -> void:
	$Player.can_move = true
	if is_mobile:
		$MobileControls.visible = true

func _on_laptop_menu_opened() -> void:
	$Player.can_move = false
	$MobileControls.visible = false

func _on_laptop_menu_closed() -> void:
	$Player.can_move = true
	if is_mobile:
		$MobileControls.visible = true
