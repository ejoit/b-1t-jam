extends Node2D


@export var sprite_texture: Texture2D
@export var Label_Text =""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = Label_Text
	$Label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):

		$Label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Label.visible = false
