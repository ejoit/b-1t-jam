extends Resource
class_name WorkerMove

@export var duration: float = 1.0

@export var speed = 100

@export var instructions: Array[Dictionary] = [
	{
		"action": "move",
		"distance": 10,
		"direction": Vector2.UP,
		"speed": 5,
		"StayTime": null,
		"ViewDirection": null
	},
	{
		"action": "move",
		"distance": 10,
		"direction": Vector2.DOWN,
		"speed": 5,
		"StayTime": null,
		"ViewDirection": null
	},
	{
		"action": "TurnView",
		"distance": 10,
		"direction": Vector2.DOWN,
		"speed": 5,
		"StayTime": null,
		"ViewDirection": Vector2.RIGHT
	},
]
