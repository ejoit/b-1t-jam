extends Node


func _ready():
	for door in get_tree().get_nodes_in_group("doors"):
		if door.doortag == Global.doorgoto:
			var player = $PLAYER
			player.global_position = door.get_node("Spawn").global_position
			break
