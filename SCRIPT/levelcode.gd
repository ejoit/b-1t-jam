extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	
	var guards = get_tree().get_nodes_in_group("player")
	var guards2 = get_tree().get_nodes_in_group("PLAYER")
	print(guards)
	print(guards2)
	
	for door in get_tree().get_nodes_in_group("doors"):
		if door.doortag == Global.doorgoto:
			var player = $PLAYER
			player.global_position = door.get_node("Spawn").global_position
			break

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_player_inchat() -> void:
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
