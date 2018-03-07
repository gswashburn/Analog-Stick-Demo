extends Node

export (PackedScene) var tree

var screensize


func _ready():
	# Dont Allow quitting by x and closing game (set this true in Game Start Screen)
	# Used to limit quit to Game Start Screen
#	get_tree().set_auto_accept_quit(false)
	
	randomize()
	
	# get Screensize and determine player size
	screensize = get_viewport_rect().size
	spawn_trees(rand_range(1,10))
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func spawn_trees(num):	
	for i in range(num):
		var game_tree = tree.instance()
		game_tree.set_scale(Vector2(2,2))
		
		# Set Random position of npc
		game_tree.position = (Vector2(rand_range(75, screensize.x - 75), rand_range(75 , screensize.y - 75)))
		$tree_container.add_child(game_tree)