extends MeshInstance3D

@onready var waterSpeed : HSlider = $"../CanvasLayer/waterSpeed"
@onready var waterHeight : HSlider = $"../CanvasLayer/waterHeight"
@onready var waterFrequency: HSlider = $"../CanvasLayer/waterFrequency"
@onready var shaderMaterial : ShaderMaterial = self.get_active_material(0)

func _ready():
	# Set up sliders with min, max, and step values
	waterSpeed.min_value = 0.1
	waterSpeed.max_value = 5.0
	waterSpeed.step = 0.1
	
	waterHeight.min_value = 0.0
	waterHeight.max_value = 1.0
	waterHeight.step = 0.05
	
	waterFrequency.min_value = 0.1
	waterFrequency.max_value = 5.0
	waterFrequency.step = 0.1

	# Connect slider signals to their respective functions
	waterSpeed.connect("value_changed", Callable(self, "_on_water_speed_changed"))
	waterHeight.connect("value_changed", Callable(self, "_on_water_height_changed"))
	waterFrequency.connect("value_changed", Callable(self, "_on_water_frequency_changed"))

func _process(delta):
	pass

func _on_water_speed_changed(value):
	shaderMaterial.set_shader_parameter("wave_speed", value)

func _on_water_height_changed(value):
	shaderMaterial.set_shader_parameter("wave_height", value)

func _on_water_frequency_changed(value):
	shaderMaterial.set_shader_parameter("wave_frequency", value)
