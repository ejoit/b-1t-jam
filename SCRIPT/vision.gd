
extends Node2D

var target: Node2D = null

var angle_cone_of_vision := deg_to_rad(30.0)
var max_view_distance := 800.0
var angle_between_rays := deg_to_rad(5.0)

func generate_raycasts() -> void:
	var ray_count := int(angle_cone_of_vision / angle_between_rays)

	for index in range(ray_count):
		var ray := RayCast2D.new()
		var angle := angle_between_rays * (index - ray_count / 2.0)

		ray.target_position = Vector2.UP.rotated(angle) * max_view_distance
		ray.enabled = true
		add_child(ray)

func _physics_process(delta: float) -> void:
	target = null

	for ray in get_children():
		if ray is RayCast2D:
			ray.force_raycast_update()

			if ray.is_colliding():
				
				var collider = ray.get_collider()
				
				if collider.is_in_group("player"):
					target = collider
					break

	var does_see_player := target != null
