extends Node

@onready var conductor = $conductor


func _on_acompanyment_1_body_entered(body):
	print("Play that bass!!")
	conductor.cue_track("bassAc")


func _on_acompanyment_1_body_exited(body):
	print("Stop that bass!!")
	conductor.cue_stop_track("bassAc")


func _on_acompanyment_2_body_entered(body):
	print("Play thoes drums!!")
	conductor.cue_track("drumAc")


func _on_acompanyment_2_body_exited(body):
	print("Stop thoes drums!!")
	conductor.cue_stop_track("drumAc")


func _on_play_button_button_down():
	print("now playing")
	conductor.cue_track("melody")
	conductor.start()


func _on_pause_button_button_down():
	conductor.pause()


func _on_stop_button_button_down():
	conductor.stop()
