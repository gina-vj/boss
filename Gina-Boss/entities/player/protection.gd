extends Node2D

var  duration : int
var max_duration:int

func is_exited_contagion_area():
	$TimerProtection.stop()
func set_duration(d):
	duration=d
func lose_duration():
	print(Bag.duration_barbijo)
	if(	$TimerProtection.is_stopped()):
		set_duration(Bag.duration_barbijo)
		$TimerProtection.start(duration)
	else:
		duration=$TimerProtection.time_left
		Bag.duration_barbijo=duration


	
