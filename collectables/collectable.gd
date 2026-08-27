@tool
extends Node2D


@onready var sprite: Sprite2D = $Sprite2D
@export var inventory: Inv
@export var item: InvItem
var used = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = item.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
