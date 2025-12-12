extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var script = load("res://enemy.gd")
	var interface_script = load("res://i_damageable.gd")

	var interface = GDSInterfaceChecker.construct_interface_from_script(interface_script)

	var interface_inline: Array[GDSIMethodInfo] = [
		GDSIMethodInfo.new("take_damage", 1, [""], [TYPE_INT], "", TYPE_NIL, [], PROPERTY_USAGE_DEFAULT),
		# MethodInfo.void_method("take_damage", 1, [""], [TYPE_INT]),
		GDSIMethodInfo.new("get_is_dead", 0, [], [], "", TYPE_BOOL, ["@is_dead_getter"]),
		# MethodInfo.getter("is_dead", "", TYPE_BOOL)
	]

	print(interface)
	print(interface_inline)

	print(GDSInterfaceChecker.is_implemented_interface(script, interface))
	print(GDSInterfaceChecker.is_implemented_interface(script, interface_inline))

	print("All done! Exiting...")
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
