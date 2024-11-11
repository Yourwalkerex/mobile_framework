extends CanvasLayer

var icon : Texture2D = preload("res://c_system_files/icon.svg")
var touchscreen : bool = false
var square_arr : Vector2 = Vector2(240,208)
var rect_arr : Vector2 = Vector2(426,240)

var touch_dict : Dictionary = {
	"touch_a" : Vector2(0,0),
	"touch_b" : Vector2(0,0),
	"touch_x" : Vector2(0,0),
	"touch_y" : Vector2(0,0),
	"touch_l" : Vector2(0,0),
	"touch_r" : Vector2(0,0),
	"touch_start" : Vector2(0,0),
	"touch_select" : Vector2(0,0),
	"touch_up" : Vector2(0,0),
	"touch_down" : Vector2(0,0),
	"touch_left" : Vector2(0,0),
	"touch_right" : Vector2(0,0),
}


func _ready() -> void:
	get_tree().get_root().size_changed.connect(resize)
	touchscreen = DisplayServer.is_touchscreen_available()
	if touchscreen == false:
		var window = get_window()
		window.size = square_arr*3
		window.content_scale_factor = 3
		#window.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND 
		%right.queue_free()
		%left.queue_free()
		await get_tree().create_timer(0.0).timeout
		%main_window.position = Vector2(0,0)
		%main_window.set_anchors_preset(Control.PRESET_FULL_RECT)
	else:
		for i : Control in %right.get_children():
			touch_dict[i.name] = i.position
	#print(touch_dict)
			
		
		#%main_window.size = window.size*3
	#print(get_tree().get_root())
	#var window = get_window()
	#window_size = window.size
	#window.size = Vector2(1600,700)
	resize()
	pass


#func _physics_process(delta: float) -> void:
	#var a : Vector2i = DisplayServer.window_get_size()
	#print(a)
	


func resize() -> void:
	#print("resize")
	var window : Vector2i = DisplayServer.window_get_size()
	#%left_label.text = str(%left.size)
	#%right_label.text = str(%right.size)
	if touchscreen == false: return
	else:
		if window.x >= window.y:
			#Get 1/4 window size to use for element sizing and positioning
			var a : int = window.x/4
			#get the 4:3.5 or 16:9 aspect ratio of the window
			var b : float = (a*2) * (0.875)		#4:3.5
			#var b : int = (a*2.x) * (0.5625)		#16:9
			
			#position the game window 1/2 way down the screen if there is a difference
			var c : float = (window.y-b)*0.5; if c < 0: c = 0
			%main_window.position = Vector2((a),(c))
			%main_window.size = Vector2(a*2,b)
			%right.size = Vector2((a),window.y)
			%right.position = Vector2((a*3),0)
			%left.size = Vector2((a),window.y)
			%left.position = Vector2(0,0)
			
			
		else:
			var right_size : Vector2i = %right.size
			#Get 1/2 window width for controller sizing and positioning
			var a : int = window.x/2
			#get the 4:3.5 or 16:9 aspect ratio of the window
			var b : float = (floori( ( (a*2) * (0.875) ) / 16) * 16)		#4:3.5
			#var b : int = (a*2.x) * (0.5625)		#16:9
			
			#find the position for the left and right controller inputs
			var c : float = (window.y) - (b)
			%main_window.position = Vector2(0,0)
			%main_window.size = Vector2(window.x,b)
			%right.size = Vector2(a,c)
			%right.position = Vector2(a,b)
			%left.size = Vector2(a,c)
			%left.position = Vector2(0,b)
			
			var defaults_abxy : Vector2 = Vector2(13.33,14.68)
			var defaults_left_right : Vector2 = Vector2(20.42,11.01)
			var defaults_start_select : Vector2 = Vector2(20,11.47)
			var defaults_udlr : Vector2 = Vector2(13.33,14.68)
			var defaults_dpad_icon : Vector2 = Vector2(13.33,14.68)
			
			var abxy : Vector2
			var left_right : Vector2
			var start_select : Vector2
			var udlr : Vector2
			var dpad_icon : Vector2
			#X.x = calc_to_percentage(%touch_x.size.x, window.x)
			#X.y = calc_to_percentage(%touch_x.size.y, (window.y-%main_window.size.y))
			abxy.x = calc_from_percentage( window.x, defaults_abxy.x)
			abxy.y = calc_from_percentage((window.y-%main_window.size.y),defaults_abxy.y)
			
			left_right.x = calc_from_percentage( window.x, defaults_left_right.x)
			left_right.y = calc_from_percentage((window.y-%main_window.size.y),defaults_left_right.y)
			
			start_select.x = calc_from_percentage( window.x, defaults_start_select.x)
			start_select.y = calc_from_percentage((window.y-%main_window.size.y),defaults_start_select.y)
			
			var asdf : Vector2
			asdf.x = calc_to_percentage(%touch_start.size.x, window.x)
			asdf.y = calc_to_percentage(%touch_start.size.y, (window.y-%main_window.size.y))
			print(asdf)
			
			udlr.x = calc_from_percentage( window.x, defaults_udlr.x)
			udlr.y = calc_from_percentage((window.y-%main_window.size.y),defaults_udlr.y)
			
			dpad_icon.x = calc_from_percentage( window.x, defaults_dpad_icon.x)
			dpad_icon.y = calc_from_percentage((window.y-%main_window.size.y),defaults_dpad_icon.y)
			
			#%label.text = str(X)
			var B : int
			#B = max(A.x,A.y)
			#%label_2.text = str(Y)
			for i : Control in %right.get_children():
				var C : Vector2 = Vector2(i.position.x,i.position.y)
				#var X : Vector2
				var D : Vector2
				var E : Vector2
				#X.x = (right_size.x - i.position.x)
				#X.y = (right_size.y - i.position.y)
				
				D.x = abs(calc_to_percentage(i.position.x,right_size.x))
				D.y = abs(calc_to_percentage(i.position.y,right_size.y))
				
				E.x = calc_from_percentage(D.x,%right.size.x)
				E.y = calc_from_percentage(D.y,%right.size.y)
				i.position = E
				if i.name == "touch_r":
					B = min(left_right.x,left_right.y)
					i.get_child(0).shape.extents.x = left_right.x
					i.get_child(0).shape.extents.y = left_right.y
					i.get_child(1).size = Vector2(left_right.x,left_right.y)
				elif i.name == "touch_start":
					#i.position = E
					B = min(start_select.x,start_select.y)
					i.get_child(0).shape.extents.x = start_select.x
					i.get_child(0).shape.extents.y = start_select.y
					i.get_child(1).size = Vector2(start_select.x,start_select.y)
				else:
					#i.position = E
					B = min(abxy.x,abxy.y)
					i.get_child(0).shape.extents.x = B
					i.get_child(0).shape.extents.y = B
					i.get_child(1).size = Vector2(B,B)
		


func calc_to_percentage(numerator: float, denominator: float) -> float:
	var output : float = numerator / denominator
	if output > 1: output -= 1
	output *= 100
	output = snappedf(output,0.01)
	return output


func calc_from_percentage(denominator: float, percentage: float) -> float:
	var output : float = (percentage/100) * denominator
	output = roundi(output)
	return output

		
		
		
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
		
		
		
		
		
		
		
		
		
		
		
		
		
	#get_viewport().get_visible_rect().size
	#print(%touch_a.size)
	#var a : TouchScreenButton = %touch_a.get_child(0)
	#var b : Shape2D = a.shape
	#var c : Vector2 = b.size
	#c = %touch_a.size
	#print(c)
	#a.shape.extents.x = %touch_a.size.x
	#a.shape.extents.y = %touch_a.size.y
	#a.texture_normal.extents.x = %touch_a.size.x
	#a.texture_normal.extents.y = %touch_a.size.y
	#a.size = %touch_a.shape.size





func _input(_event) -> void:
	if Input.is_action_just_pressed("ui_up") and Input.is_action_just_pressed("ui_left"):
		print("up_left")







#
#func _process(_delta) -> void: 
	#if Input.is_action_just_pressed("my_action"): 
		#print("button pressed")
#
#func _on_button_pressed() -> void: 
	#var e = InputEventAction.new() 
	#e.action = "action" 
	#e.pressed = true 
	#Input.parse_input_event(e) 
	## or 
	#Input.action_press("action")
#
#func _on_button_released() -> void: 
	#var e = InputEventAction.new() 
	#e.action = "action" 
	#e.pressed = false 
	#Input.parse_input_event(e) 
	## or (This isn't required in this case) 
	#Input.action_release("action")


#func _on_up_pressed() -> void:
	#var e : InputEventAction = InputEventAction.new()
	#e.action = "ui_up"
	#e.pressed = true
	#Input.parse_input_event(e)
	#Input.action_press("ui_up")
	#print("eUP")
	#pass # Replace with function body.
#
#
#func _on_up_button_down() -> void:
	#print("up")
	#pass # Replace with function body.
