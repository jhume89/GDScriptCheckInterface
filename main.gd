extends Node

const VERBOSE: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var script = load("res://enemy.gd")
	var broken_script = load("res://enemy_broken.gd")
	var i_damageable_script = load("res://i_damageable.gd")
	var i_respawnable_script = load("res://i_respawnable.gd")

	var i_damageable = GDSInterfaceChecker.construct_interface_from_script(i_damageable_script)
	var i_respawnable = GDSInterfaceChecker.construct_interface_from_script(i_respawnable_script)

	var adhoc_interface_rules: Array[GDSIMethodInfo] = [
		GDSIMethodInfo.new("take_damage", 1, [""], [TYPE_INT], "", TYPE_NIL, [], PROPERTY_USAGE_DEFAULT),
		# GDSIMethodInfo.void_method("take_damage", 1, [""], [TYPE_INT]),
		GDSIMethodInfo.new("get_is_dead", 0, [], [], "", TYPE_BOOL, ["@is_dead_getter"]),
		# GDSIMethodInfo.getter("is_dead", "", TYPE_BOOL)
	]

	if VERBOSE:
		print_constructed_interfaces([i_damageable_script, i_respawnable_script])
		print_adhoc_rules(adhoc_interface_rules)

	print("Checking %s..." % script.resource_path)
	print("    i_damageable:  ", GDSInterfaceChecker.is_implemented_interface(script, i_damageable))
	print("    i_respawnable: ", GDSInterfaceChecker.is_implemented_interface(script, i_respawnable))
	print("    Adhoc rules:   ", GDSInterfaceChecker.is_implemented_interface(script, adhoc_interface_rules))
	print("")
	print("Checking %s..." % broken_script.resource_path)
	print("    i_damageable:  ", GDSInterfaceChecker.is_implemented_interface(broken_script, i_damageable))
	print("    i_respawnable: ", GDSInterfaceChecker.is_implemented_interface(broken_script, i_respawnable))
	print("    Adhoc rules:   ", GDSInterfaceChecker.is_implemented_interface(broken_script, adhoc_interface_rules))
	print("")

	print("All done! Exiting...")
	get_tree().quit()

func print_raw_method_lists(scripts: Array[Script]) -> void:
	for scr in scripts:
		print("get_method_list() for %s:" % scr.resource_path)
		print(scr.get_method_list(), "\n")

func print_constructed_interfaces(scripts: Array[Script]) -> void:
	for scr in scripts:
		print("Constructed interface for %s:" % scr.resource_path)
		print(GDSInterfaceChecker.construct_interface_from_script(scr), "\n")

func print_adhoc_rules(ruleset: Array[GDSIMethodInfo]) -> void:
	#for ruleset in rulesets:
	print("Adhoc ruleset:")
	print(ruleset, "\n")

func test_adhoc_rules():
	var adhoc_interface_rules: Array[GDSIMethodInfo] = [
		GDSIMethodInfo.new("take_damage", 1, [""], [TYPE_INT], "", TYPE_NIL, [], PROPERTY_USAGE_DEFAULT),
		# GDSIMethodInfo.void_method("take_damage", 1, [""], [TYPE_INT]),
		GDSIMethodInfo.new("get_is_dead", 0, [], [], "", TYPE_BOOL, ["@is_dead_getter"]),
		# GDSIMethodInfo.getter("is_dead", "", TYPE_BOOL)
		GDSIMethodInfo.new(
			"respawn", 		# method_name
			1, 				# args_count
			[""], 			# args_class_name
			[TYPE_ARRAY], 	# args_type
			"Enemy", 		# return_class_name
			TYPE_OBJECT, 	# return_type
			[], 				# aliases
			-1,				# return_flags
			-1,				# return_hint
			"",				# return_hint_string
			[-1],			# args_flags
			[PROPERTY_HINT_ARRAY_TYPE],		# args_hints
			["Marker2D"]		# args_hints_strings
		)
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
