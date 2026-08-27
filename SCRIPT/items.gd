extends Node2D

signal COFFEEPLUS
@onready var collision = $Area2D/CollisionShape2D
@onready var used = false


@export var item: InvItem
@export var inventory: Inv
#@onready var powerup: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("enter")
	if body.is_in_group("player"):
		if used == false:
			#powerup.play()


			$Area2D.monitoring = false
			$Area2D.monitorable = false
			#$Sprite2D.hide()
			$Sprite2D.hide()
			print("player enter")
			used = true
			
			
			inventory.items.append(item)
			queue_free()

		else:
			print("NO")
 
