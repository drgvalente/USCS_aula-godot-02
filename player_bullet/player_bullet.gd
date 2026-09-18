extends Area3D

var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	translate(Vector3.FORWARD * speed * delta)
	pass
	
func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		body.queue_free()
	queue_free()
	pass # Replace with function body.
