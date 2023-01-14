extends Node

@onready var tree = preload("res://tree.tscn")

var screensize
var rng

func _ready():
	# Dont Allow quitting by x and closing game (set this true in Game Start Screen)
	# Used to limit quit to Game Start Screen
#	get_tree().set_auto_accept_quit(false)
	
	rng = RandomNumberGenerator.new()
	rng.randomize()

	
	# get Screensize and determine player size
	screensize = get_viewport().size
	spawn_trees(rng.randi_range(0, 10))
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func spawn_trees(num):	
	for i in range(num):
		var game_tree = tree.instantiate()
		game_tree.set_scale(Vector2(2,2))
		
		# Set Random position of npc
		game_tree.position = (Vector2(rng.randi_range(75, screensize.x - 75), rng.randi_range(75 , screensize.y - 75)))
		$tree_container.add_child(game_tree)
