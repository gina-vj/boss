extends ActionableItem

export (int) var duration
	
func is_throwable():
	return true

func get_duration():
	return duration
