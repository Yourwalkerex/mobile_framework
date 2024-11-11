extends Node

var is_dying : bool = false

func _ready() -> void:
	Engine.max_fps = 60
	#get_tree().get_root().size_changed.connect(resize)
	#resize()
	pass # Replace with function body.


func resize() -> void:
	pass
	#var a : Vector2i = DisplayServer.window_get_size()
	#if a.x <= a.y : # Portrait
		#%main_window.position = Vector2(0,0)
		#var b : float = a.x
		#var c : float = (a.x) * (0.75)
		#%width.text = str(%main_window.size.x)
		#%height.text = str(%main_window.size.y)
		#%target_width.text = str(b)
		#%target_height.text = str(c)
		#$main_window.size = Vector2(b,c)
		#
		#var d = a.y - %main_window.size.y
		#
		#%controll_area.size = Vector2(b,d)
	#else: # Landscape
		##first we have to get the window size, and find our ratios
		#var b : float = a.x
		#var c : int = b/5
		#
		#print(c)
		#%main_window.position = Vector2(c,0)
		

#TODO make it so that the main window is the smaller of the two of
# width or height.


# if height is bigger then we are in portrait mode
# screen at the top, controlls at the bottom

# else we are in landscape mode, controlls at the side
#screen in the center.







func _on_die_pressed() -> void:
	if is_dying == false:
		is_dying = true
		%fade.visible = true
		%fade.play("fade")
		await %fade.animation_finished
		%sprite.visible = false
		await get_tree().create_timer(0.5).timeout
		$sprite.visible = true
		%fade.play("stop")
		is_dying = false
	pass # Replace with function body.
