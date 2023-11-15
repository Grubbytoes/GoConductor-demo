extends Node

enum Cmd {START, STOP}

@export var bpm: int = 120
@export var bus: String = "Master"
@export var lead_track: GCTrack

@onready var metronome = $metronome

var beatno = 0
var command_queue = []
# Used if any track is playing, so we can know whether or not to count up time
var is_playing = false 
# Keeps track of currently playing time
var play_head: float = 0.0
# A list of all tracks currently playing
var tracks_playing = []

func start():
	# Set the metronome going and playing to true: both of which are important
	# to keep things nicely in time
	metronome.wait_time = 60/bpm
	metronome.start()
	is_playing = true
	
	# Poll the queue for any commands that have been put in place
	print(command_queue)
	_poll_queue()
	
	# Play any tracks that were playing already
	for track in tracks_playing:
		track.play(play_head)


# Pauses all tracks
func pause():
	is_playing = false
	for track in tracks_playing:
		track.stop()


# Stops all tracks and resets play time to 0 
func stop():
	# This acts the same as a pause, except we reset time to 0!
	# ... I think
	play_head = 0.0
	pause()


func cue_track(track_name):
	command_queue.append([Cmd.START, track_name])


func cue_stop_track(track_name):
	command_queue.append([Cmd.STOP, track_name])


func play_track(track_name):
	var track = find_child(track_name)
	
	# Here is a simple is null check to see if the track exists.
	# TODO I'd like more """pythonic""" type checking - making sure
	# the node 'quacks', but this works for now 
	if track != null:
		tracks_playing.append(track)
	else:
		return
	
	# Check that the track is assigned to the correct bus
	if track.current_bus != bus:
		track.set_bus(bus)
	
	track.play(play_head)


func stop_track(track_name):
	var track = find_child(track_name)
	track.stop()
	tracks_playing.erase(track)


func _poll_queue():
	if command_queue.is_empty():
		return
	
	var cmd
	var target
	var buffer
	# At the moment, commands will simply be names of tracks to play
	while !command_queue.is_empty():
		buffer = command_queue.pop_front()
		cmd = buffer[0]
		target = buffer[1]
		
		match cmd:
			Cmd.START:
				play_track(target)
			Cmd.STOP:
				stop_track(target)

func _on_metronome_timeout():
	pass


func _process(delta):
	if is_playing:
		play_head += delta
		_poll_queue()

