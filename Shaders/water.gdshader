shader_type spatial;

uniform vec4 water_color : source_color = vec4(0.0, 0.5, 1.0, 0.5);
uniform float wave_speed = 1.4;
uniform float wave_height = 0.3;
uniform float wave_frequency = 1.0;
uniform sampler2D noise_texture;
uniform float fresnel_power = 2.0;
uniform vec4 deep_water_color : source_color = vec4(0.0, 0.2, 0.5, 1.0);

varying float wave_value;
varying vec3 world_position;

void vertex() {
    world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
    
    vec2 noise_uv = world_position.xz * 0.1 + TIME * 0.05;
    float noise = texture(noise_texture, noise_uv).r;
    
    wave_value = sin(TIME * wave_speed + world_position.x * wave_frequency) * wave_height;
    wave_value += sin(TIME * wave_speed * 0.8 + world_position.z * wave_frequency * 1.2) * wave_height;
    wave_value += (noise - 0.5) * wave_height * 0.5;
    
    VERTEX.y += wave_value;
    
    // Compute normal
    NORMAL = normalize(vec3(
        -wave_height * wave_frequency * cos(TIME * wave_speed + world_position.x * wave_frequency),
        1.0,
        -wave_height * wave_frequency * cos(TIME * wave_speed * 0.8 + world_position.z * wave_frequency * 1.2)
    ));
}

void fragment() {
    // Fresnel effect
    float fresnel = pow(1.0 - dot(NORMAL, VIEW), fresnel_power);
    
    // Mix deep and shallow water colors based on depth and fresnel
    vec4 final_color = mix(deep_water_color, water_color, fresnel);
    
    // Apply wave effect to color
    final_color.rgb += vec3(wave_value * 0.05);
    
    ALBEDO = final_color.rgb;
    ALPHA = final_color.a;
    
    // Add some specularity
    METALLIC = 0.1;
    ROUGHNESS = 0.2;
    

}