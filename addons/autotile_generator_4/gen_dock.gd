@tool
extends VBoxContainer


signal generated

const CUTS := {
	"full_top_left": {
		"position": Vector2i(0, 0),
		"results": [
			Vector2i(4, 0),
			Vector2i(6, 1),
			Vector2i(5, 2),
			Vector2i(6, 2),
			Vector2i(7, 2),
			Vector2i(6, 3),
			Vector2i(11, 1),
			Vector2i(9, 2),
			Vector2i(10, 2),
			Vector2i(11, 2),
			Vector2i(9, 3),
			Vector2i(10, 3),
			Vector2i(11, 3),
		],
	},
	"full_top_right": {
		"position": Vector2i(1, 0),
		"results": [
			Vector2i(7, 0),
			Vector2i(5, 1),
			Vector2i(4, 2),
			Vector2i(5, 2),
			Vector2i(6, 2),
			Vector2i(5, 3),
			Vector2i(8, 1),
			Vector2i(9, 1),
			Vector2i(8, 2),
			Vector2i(9, 2),
			Vector2i(8, 3),
			Vector2i(9, 3),
			Vector2i(10, 3),
		],
	},
	"full_bottom_left": {
		"position": Vector2i(0, 1),
		"results": [
			Vector2i(6, 0),
			Vector2i(5, 1),
			Vector2i(6, 1),
			Vector2i(7, 1),
			Vector2i(6, 2),
			Vector2i(4, 3),
			Vector2i(9, 0),
			Vector2i(10, 0),
			Vector2i(11, 0),
			Vector2i(9, 1),
			Vector2i(11, 1),
			Vector2i(9, 2),
			Vector2i(11, 2),
		],
	},
	"full_bottom_right": {
		"position": Vector2i(1, 1),
		"results": [
			Vector2i(5, 0),
			Vector2i(4, 1),
			Vector2i(5, 1),
			Vector2i(6, 1),
			Vector2i(5, 2),
			Vector2i(7, 3),
			Vector2i(8, 0),
			Vector2i(9, 0),
			Vector2i(10, 0),
			Vector2i(8, 1),
			Vector2i(8, 2),
			Vector2i(9, 2),
			Vector2i(10, 2),
		],
	},
	"horizontal_top_left": {
		"position": Vector2i(2, 0),
		"results": [
			Vector2i(2, 0),
			Vector2i(3, 0),
			Vector2i(2, 3),
			Vector2i(3, 3),
			Vector2i(5, 0),
			Vector2i(6, 0),
			Vector2i(10, 0),
			Vector2i(11, 0),
		],
	},
	"horizontal_top_right": {
		"position": Vector2i(3, 0),
		"results": [
			Vector2i(1, 0),
			Vector2i(2, 0),
			Vector2i(1, 3),
			Vector2i(2, 3),
			Vector2i(5, 0),
			Vector2i(6, 0),
			Vector2i(8, 0),
			Vector2i(10, 0),
		],
	},
	"horizontal_bottom_left": {
		"position": Vector2i(2, 1),
		"results": [
			Vector2i(2, 2),
			Vector2i(3, 2),
			Vector2i(2, 3),
			Vector2i(3, 3),
			Vector2i(5, 3),
			Vector2i(6, 3),
			Vector2i(9, 3),
			Vector2i(11, 3),
		],
	},
	"horizontal_bottom_right": {
		"position": Vector2i(3, 1),
		"results": [
			Vector2i(1, 2),
			Vector2i(2, 2),
			Vector2i(1, 3),
			Vector2i(2, 3),
			Vector2i(5, 3),
			Vector2i(6, 3),
			Vector2i(8, 3),
			Vector2i(9, 3),
		],
	},
	"vertical_top_left": {
		"position": Vector2i(4, 0),
		"results": [
			Vector2i(0, 1),
			Vector2i(0, 2),
			Vector2i(1, 1),
			Vector2i(1, 2),
			Vector2i(4, 1),
			Vector2i(4, 2),
			Vector2i(8, 1),
			Vector2i(8, 3),
		],
	},
	"vertical_top_right": {
		"position": Vector2i(5, 0),
		"results": [
			Vector2i(0, 1),
			Vector2i(0, 2),
			Vector2i(3, 1),
			Vector2i(3, 2),
			Vector2i(7, 1),
			Vector2i(7, 2),
			Vector2i(11, 2),
			Vector2i(11, 3),
		],
	},
	"vertical_bottom_left": {
		"position": Vector2i(4, 1),
		"results": [
			Vector2i(0, 0),
			Vector2i(0, 1),
			Vector2i(1, 0),
			Vector2i(1, 1),
			Vector2i(4, 1),
			Vector2i(4, 2),
			Vector2i(8, 0),
			Vector2i(8, 1),
		],
	},
	"vertical_bottom_right": {
		"position": Vector2i(5, 1),
		"results": [
			Vector2i(0, 0),
			Vector2i(0, 1),
			Vector2i(3, 0),
			Vector2i(3, 1),
			Vector2i(7, 1),
			Vector2i(7, 2),
			Vector2i(11, 0),
			Vector2i(11, 2),
		],
	},
	"corner_top_left": {
		"position": Vector2i(6, 0),
		"results": [
			Vector2i(0, 0),
			Vector2i(0, 3),
			Vector2i(1, 0),
			Vector2i(1, 3),
			Vector2i(8, 0),
		],
	},
	"corner_top_right": {
		"position": Vector2i(7, 0),
		"results": [
			Vector2i(0, 0),
			Vector2i(0, 3),
			Vector2i(3, 0),
			Vector2i(3, 3),
			Vector2i(11, 0),
		],
	},
	"corner_bottom_left": {
		"position": Vector2i(6, 1),
		"results": [
			Vector2i(0, 2),
			Vector2i(0, 3),
			Vector2i(1, 2),
			Vector2i(1, 3),
			Vector2i(8, 3),
		],
	},
	"corner_bottom_right": {
		"position": Vector2i(7, 1),
		"results": [
			Vector2i(0, 2),
			Vector2i(0, 3),
			Vector2i(3, 2),
			Vector2i(3, 3),
			Vector2i(11, 3),
		],
	},
	"inverted_top_left": {
		"position": Vector2i(8, 0),
		"results": [
			Vector2i(2, 1),
			Vector2i(3, 1),
			Vector2i(2, 2),
			Vector2i(3, 2),
			Vector2i(7, 0),
			Vector2i(5, 1),
			Vector2i(7, 1),
			Vector2i(4, 3),
			Vector2i(5, 3),
			Vector2i(7, 3),
			Vector2i(9, 0),
			Vector2i(9, 1),
			Vector2i(8, 2),
		],
	},
	"inverted_top_right": {
		"position": Vector2i(9, 0),
		"results": [
			Vector2i(1, 1),
			Vector2i(2, 1),
			Vector2i(1, 2),
			Vector2i(2, 2),
			Vector2i(4, 0),
			Vector2i(4, 1),
			Vector2i(6, 1),
			Vector2i(4, 3),
			Vector2i(6, 3),
			Vector2i(7, 3),
			Vector2i(9, 0),
			Vector2i(11, 1),
			Vector2i(10, 2),
		],
	},
	"inverted_bottom_left": {
		"position": Vector2i(8, 1),
		"results": [
			Vector2i(2, 0),
			Vector2i(3, 0),
			Vector2i(2, 1),
			Vector2i(3, 1),
			Vector2i(4, 0),
			Vector2i(5, 0),
			Vector2i(7, 0),
			Vector2i(5, 2),
			Vector2i(7, 2),
			Vector2i(7, 3),
			Vector2i(8, 2),
			Vector2i(10, 2),
			Vector2i(10, 3),
		],
	},
	"inverted_bottom_right": {
		"position": Vector2i(9, 1),
		"results": [
			Vector2i(1, 0),
			Vector2i(2, 0),
			Vector2i(1, 1),
			Vector2i(2, 1),
			Vector2i(4, 0),
			Vector2i(6, 0),
			Vector2i(7, 0),
			Vector2i(4, 2),
			Vector2i(6, 2),
			Vector2i(4, 3),
			Vector2i(9, 1),
			Vector2i(11, 1),
			Vector2i(10, 3),
		],
	},
}
var fd: EditorFileDialog


func _on_upload_pressed() -> void:
	fd.file_mode = EditorFileDialog.FILE_MODE_OPEN_FILE
	fd.popup_centered()


func on_file_dialog_file_selected(path: String) -> void:
	if fd.file_mode == EditorFileDialog.FILE_MODE_OPEN_FILE:
		var resource = load(path)
		if not resource is Texture:
			return
		$Actual.texture = resource
		$Generate.disabled = false
	else:
		generate(path)


func generate(path: String) -> void:
	var image: Image = $Actual.texture.get_image()
	var tile_size: Vector2i = image.get_size() / Vector2i(5, 1)
	var result := Image.create(tile_size.x * 12, tile_size.y * 4, false, Image.FORMAT_RGBA8)
	for key in CUTS:
		for result_pos in CUTS[key].results:
			var offset := Vector2i.ZERO
			if "top_right" in key:
				offset = Vector2i(tile_size.x / 2, 0)
			elif "bottom_left" in key:
				offset = Vector2i(0, tile_size.y / 2)
			elif "bottom_right" in key:
				offset = Vector2i(tile_size.x / 2, tile_size.y / 2)
			result.blit_rect(image, Rect2i(CUTS[key].position * tile_size / 2, tile_size / 2), result_pos * tile_size + offset)
	result.save_png(path)
	generated.emit()


func _on_generate_pressed() -> void:
	fd.file_mode = EditorFileDialog.FILE_MODE_SAVE_FILE
	fd.popup_centered()
