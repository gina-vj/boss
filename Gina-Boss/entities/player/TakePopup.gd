extends Popup
signal item_taken()

var selectedItem

func _on_Gina_open_item_popup(item):
	selectedItem = item
	popup_centered_clamped()

func _on_Gina_close_item_popup():
	selectedItem = null
	visible = false
	
func _on_ToolButton_pressed():
	emit_signal("item_taken", selectedItem)
	visible = false
