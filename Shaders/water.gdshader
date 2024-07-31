shader_type spatial;

uniform vec4 water_color : source_color = vec4(0.0, 0.5, 1.0, 0.5); // RGBA for water color and transparency
uniform float wave_speed = 1.4; // Speed of the waves
uniform float wave_height = 0.3; // Height of the waves
uniform float wave_frequency = 1.0; // Frequency of the waves

varying float wave_value;

void vertex() {
    // Calculate the wave effect
    wave_value = sin(TIME * wave_speed + VERTEX.x * wave_frequency) * wave_height;
    wave_value += sin(TIME * wave_speed + VERTEX.z * wave_frequency) * wave_height;
    
    // Apply the wave effect to the vertex position
    VERTEX.y += wave_value;
}

void fragment() {
    // Set the fragment color
    ALBEDO = water_color.rgb;
    ALPHA = water_color.a;
    
    // Optional: Use wave_value to affect the fragment shader
    // For example, you could use it to adjust the color or transparency
    // ALBEDO += vec3(wave_value * 0.1);
}