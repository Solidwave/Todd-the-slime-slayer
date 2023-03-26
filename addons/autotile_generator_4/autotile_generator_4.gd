@tool
extends EditorPlugin


var dock: Control
var fd: EditorFileDialog


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	dock = preload("res://addons/autotile_generator_4/gen_dock.tscn").instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UL, dock)
	fd = EditorFileDialog.new()
	fd.add_filter("*.bmp")
	fd.add_filter("*.dds")
	fd.add_filter("*.exr")
	fd.add_filter("*.hdr")
	fd.add_filter("*.jpg")
	fd.add_filter("*.jpeg")
	fd.add_filter("*.png")
	fd.add_filter("*.tga")
	fd.add_filter("*.svg")
	fd.add_filter("*.svgz")
	fd.add_filter("*.webp")
	get_editor_interface().get_base_control().add_child(fd)
	dock.fd = fd
	fd.file_selected.connect(dock.on_file_dialog_file_selected)
	dock.generated.connect(on_generated)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_control_from_docks(dock)
	dock.free()
	fd.free()


func on_generated() -> void:
	get_editor_interface().get_resource_filesystem().scan()
