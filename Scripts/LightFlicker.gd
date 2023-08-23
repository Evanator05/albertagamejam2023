extends LightColor

var timer = null

func _ready():
	super._ready()
	randomize()
	timer = get_tree().create_timer(randf_range(0.8, 0.1))
	timer.timeout.connect(on_timer_timeout)

func on_timer_timeout():
	timer = get_tree().create_timer(randf_range(0.8, 0.1))
	timer.timeout.connect(on_timer_timeout)
	light_energy = randf_range(0.0, 1.0)
