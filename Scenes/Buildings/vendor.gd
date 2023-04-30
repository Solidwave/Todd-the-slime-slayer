extends StaticBody2D
@onready var vendor_ui = $CanvasLayer/VendorUI


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_clickable_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch && event.pressed:
		vendor_ui.visible = !vendor_ui.visible
		
	
	
	
