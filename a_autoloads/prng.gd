## A Pseudo Random Number Generator with accompnying functions
##
##	PRNG Tables are a staple of early video games and allow for determinstic
##	generation of of random numbers.  This will make your game generate the 
##	same outcomes of any random generation as long as the states are the same
##	across instances.
class_name PseudoRandomNumberGenerator extends Node


##	The starting seed of the prng table, feel free to change this to any int
##	of your choice.
var prng_seed : int = 221268386
##	The state of the prng, this combined with the seed will insure that the prng
##	will return the same value each time the circumstances are the same.
var prng_state : int = -1998697397116950260
##	The prng_table is an array of 256 ints ranging from 0 to 255 in a random order.
var prng_table : Array[int] = []
##	The prng_index points to which of the indices in the prng_table we want to pull
##	at any given time
var prng_index : int = 0
##	This is just a reference to godot's built in RandomNumberGenerator class that
##	we use to start everythign.
var rng : RandomNumberGenerator


func _ready() -> void:
	seed(prng_seed)
	rng = RandomNumberGenerator.new()
	rng.seed = prng_seed
	rng.state = prng_state
	generate_prng_table()


##	Generates and randomizes the PRNG table starting at 0 and counting up to 255,
##	adding each int to the prng_table array.  It then suffles the array giving 
##	us our PseudoRandom table.
func generate_prng_table() -> void:
	var i : int = 0
	while i < 256:
		prng_table.append(i)
		i += 1
	prng_table.shuffle()
	#left off by default, uncomment if you need
	#to see the values of the prng table
	#print(prng_table)


##	This method is used in other scripts to set godot's RandomNumberGenerator state
##	to the state of prng and the RandomNumberGenerator seed to the current prng_index
##	value.
func set_rng() -> void:
	rng.state = prng_state
	rng.seed = prng_index


##	Advances the prng_index value by the argument value, if this causes the prng_index 
##	to be equal to or greater than 256 then reduces the prng_index by 256 leaving us
##	us with a value between 0 and 255 inclusive.
func advance_prng(arg:int) -> void:
	prng_index += arg
	if prng_index >= 256:
		prng_index -= 256


##	This method returns the int stored in the prng_table at the prng_index location.
func get_prng_value() -> int:
	var value : int = 0
	value = prng_table[prng_index]
	return value
