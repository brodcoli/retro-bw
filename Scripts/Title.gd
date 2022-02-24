extends Label

const _fade_in_duration = 500
const _display_duration = 2000
const _fade_out_duration = 300
var start = 0
var _mode = _modes.INVISIBLE

enum _modes { INVISIBLE, FADE_IN, DISPLAY, FADE_OUT }

func display(text: String):
	_mode = _modes.FADE_IN
	start = OS.get_ticks_msec()
	self.text = text
	
func _process(delta: float):
	var now = OS.get_ticks_msec()
	var time = float(now - start)
	if _mode == _modes.FADE_IN:
		visible = true
		percent_visible = time / _fade_in_duration
		if time >= _fade_in_duration:
			_mode = _modes.DISPLAY
			start = now
	elif _mode == _modes.DISPLAY:
		if time >= _display_duration:
			_mode = _modes.FADE_OUT
			start = now
	elif _mode == _modes.FADE_OUT:
		percent_visible = 1 - time / _fade_out_duration
		if time >= _fade_out_duration:
			visible = false
			_mode = _modes.INVISIBLE
			start = now
	
	
	
