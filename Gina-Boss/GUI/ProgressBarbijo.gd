extends TextureProgress

func _ready():
	max_value=FaceMask.protection_points

func _physics_process(_delta):
	visible=PlayerData.using_area_protection()
	if visible:
		value=PlayerData.area_protection.current_protection_points
	if value==max_value:
		$FinalProgressBar.visible=true
	else:
		$FinalProgressBar.visible=false
