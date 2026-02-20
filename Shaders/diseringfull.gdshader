shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform float dither_repeat = 1.0;
uniform float dither_strength = 1.0;      // смешивание с исходной сценой
uniform float min_dither_brightness = 0.1;

uniform vec4 color_a = vec4(0.2, 0.0, 0.0, 1.0); // светлый фон
uniform vec4 color_b = vec4(0.8, 0.4, 0.2, 1.0); // цвет точки

uniform float max_radius = 0.45; // максимальный радиус круга в UV

void fragment() {
    vec3 color_in = texture(screen_texture, SCREEN_UV).rgb;
    float brightness = dot(color_in, vec3(0.299, 0.587, 0.114));

    if (brightness < min_dither_brightness) {
        COLOR = vec4(color_a.rgb, 1.0);
    } else {
        vec2 tex_size = vec2(textureSize(screen_texture, 0));
        vec2 pixel_coord = SCREEN_UV * tex_size / dither_repeat + vec2(TIME*0.3, TIME*0.3);

        float cell_size = 4.0;

        vec2 cell_center = (floor(pixel_coord / cell_size) + 0.5) * cell_size;

        vec2 offset = pixel_coord - cell_center;
        float dist = length(offset) / cell_size;

        float radius = max_radius * (1.0 - brightness);

        // маска круга
        float mask = smoothstep(radius, radius - 0.02, dist);

        vec3 circle_color = color_b.rgb;

        vec3 final_color = mix(circle_color, color_a.rgb, mask);

        COLOR = vec4(mix(color_in, final_color, dither_strength), 1.0);
		
    }
}
