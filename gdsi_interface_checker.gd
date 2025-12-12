extends Node

func _ready() -> void:
	var script = load("res://enemy.gd")

	var interface : Array[MethodInfo] = [
		MethodInfo.new("take_damage", 1, [""], [TYPE_INT], "", TYPE_NIL, [], PROPERTY_USAGE_DEFAULT),
		# MethodInfo.void_method("take_damage", 1, [""], [TYPE_INT]),
		MethodInfo.new("get_is_dead", 0, [], [], "", TYPE_BOOL, ["@is_dead_getter"]),
		# MethodInfo.getter("is_dead", "", TYPE_BOOL)
	]

	print(is_implemented_interface(script, interface))



		)

static func is_implemented_interface(script: GDScript, interface: Array[GDSIMethodInfo]) -> bool:
	var method_info = script.get_script_method_list()

	return interface.all(func(req:GDSIMethodInfo): return method_info.any(func(m:Dictionary):
		var method_name : String = m["name"]
		var args : Array = m["args"]
		var ret : Dictionary = m["return"]

		var valid_names = req.aliases.duplicate()
		valid_names.append(req.name)
		if not valid_names.has(method_name):
			return false

		if args.size() != req.args_count:
			return false

		for i in args.size():
			if (args[i]["type"] != req.args_type[i] or
				args[i]["class_name"] != req.args_class_name[i]
			):
				return false

			if req.args_flags.size() > i and req.args_flags[i] != -1:
				if (args[i]["usage"] & req.args_flags[i]) != req.args_flags[i]:
					return false

			if req.args_hints.size() > i and req.args_hints[i] != -1:
				if args[i]["hint"] != req.args_hints[i]:
					return false

			if req.args_hints_strings.size() > i and req.args_hints_strings[i] != "":
				if args[i]["hint_string"] != req.args_hints_strings[i]:
					return false

		if (ret["type"] != req.return_type or
			ret["class_name"] != req.return_class_name
		):
			return false

		if req.return_flags != -1 and (ret["usage"] & req.return_flags) != req.return_flags:
			return false

		if req.return_hint != -1 and ret["hint"] != req.return_hint:
			return false

		if req.return_hint_string != "" and ret["hint_string"] != req.return_hint_string:
			return false

		return true
	))
