extends MarginContainer

@onready var animation_player = $"../AnimationPlayer"
signal toggle_options
@onready var confirmation_dialog = $"../ConfirmationDialog"

func _ready():
	modulate.a = 0
	visible = false
func _on_game_play_ui_open_options():
	if modulate.a == 1:
		visible = false
		animation_player.play_backwards("options_appear")
	else:
		visible = true
		animation_player.play("options_appear")
	


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/control.tscn")

func _on_restart_button_pressed():
	get_tree().reload_current_scene()


func _on_options_button_pressed():
	animation_player.play("open_options")


func _on_quit_button_pressed():
	confirmation_dialog.dialog_text = 'Are you sure you want to quit?'
	confirmation_dialog.confirmed.connect(quit)
	confirmation_dialog.popup_centered()
	confirmation_dialog.visible = true
	
func quit():
	get_tree().quit()
