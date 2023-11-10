class_name GCTrack
extends Node


@export var stream: AudioStream


@onready var stream_player = $internalStreamPlayer
@onready var current_bus = stream_player.get_bus()


func set_bus(new_bus):
	stream_player.set_bus(new_bus)


func play(position = 0.0):
	stream_player.stream = stream
	stream_player.play(position)


func stop():
	stream_player.stop()


func get_length():
	stream_player.get_stream().length
