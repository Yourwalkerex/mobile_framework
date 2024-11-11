extends CharacterBody2D

@export var max_speed : int = 60


var input : Vector2 = Vector2.ZERO
var movable : bool = true

#var swing_arr : Array[int] = [0,22,45,66,90,122]
var swing_arr : Array[int] = [122,90,66,45,22,0]

# Called when the node enters the scene tree for the first time.
func _ready():
	#signal_bus.connect("toggle_movement",on_toggle_movement)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_movement(delta)
	pass


func on_toggle_movement(move:bool):
	movable = move


func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input


func player_movement(_delta):
	if self.movable == false: return
	elif self.movable == true:
		input = get_input()
		if input == Vector2.ZERO: velocity = Vector2.ZERO
		else:
			velocity = (input * max_speed)
			if velocity.x != 0 and velocity.y != 0:	# DIAGONAL #
				velocity = (max_speed * input)
			else:
				velocity = (max_speed * input)
	move_and_slide()
	global_position = floor(global_position)


func _input(_event) -> void:
	if Input.is_action_just_pressed("controller_a"):
		print("Controller_A")
		if self.movable == true:
			
			
			#self.movable = not self.movable
			#var a : Vector2 = %stabs.get_child(0).global_position
			#var b : Vector2 = %stabs.get_child(1).global_position
			#var c : Vector2 = %stabs.get_child(2).global_position
			#var d : CollisionShape2D = %sword.get_child(1)
			#d.disabled = false
			#%sword.global_position = a
			#%sword.visible = true
			#await get_tree().create_timer(0.1).timeout
			#%sword.global_position = b
			#await get_tree().create_timer(0.1).timeout
			#%sword.global_position = c
			#await get_tree().create_timer(0.1).timeout
			#%sword.visible = false
			#%sword.position = Vector2.ZERO
			#d.disabled = true
			#self.movable = not self.movable
			
			
			self.movable = not self.movable
			var a : Vector2 = %swings.get_child(0).global_position
			var b : Vector2 = %swings.get_child(1).global_position
			var c : Vector2 = %swings.get_child(2).global_position
			var d : Vector2 = %swings.get_child(3).global_position
			var e : Vector2 = %swings.get_child(4).global_position
			var f : Vector2 = %swings.get_child(5).global_position
			var A : CollisionShape2D = %sword.get_child(1)
			print(swing_arr)
			A.disabled = false
			%sword.global_position = a
			%sword.visible = true
			%sword.rotation = swing_arr[0]
			print(%sword.rotation)
			await get_tree().create_timer(0.5).timeout
			%sword.global_position = b
			%sword.rotation = swing_arr[1]
			print(%sword.rotation)
			await get_tree().create_timer(0.5).timeout
			%sword.global_position = c
			%sword.rotation = swing_arr[2]
			print(%sword.rotation)
			await get_tree().create_timer(0.5).timeout
			%sword.global_position = d
			%sword.rotation = swing_arr[3]
			print(%sword.rotation)
			await get_tree().create_timer(0.5).timeout
			%sword.global_position = e
			%sword.rotation = swing_arr[4]
			print(%sword.rotation)
			await get_tree().create_timer(0.5).timeout
			%sword.global_position = f
			%sword.rotation = swing_arr[5]
			print(%sword.rotation)
			await get_tree().create_timer(0.5).timeout
			%sword.visible = false
			%sword.position = Vector2.ZERO
			A.disabled = true
			self.movable = not self.movable
			
		
	pass
