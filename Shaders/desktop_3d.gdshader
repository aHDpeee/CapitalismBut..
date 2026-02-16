shader_type spatial;
render_mode cull_back;

uniform sampler2D albedo_texture;

uniform float grid_size = 16.0;
uniform float max_radius = 0.5;
uniform float dither_strength = 1.0;

uniform vec4 color_dot = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 color_bg = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    // базовый цвет текстуры
    vec3 tex_col = texture(albedo_texture, UV).rgb;

    // яркость для радиуса круга
    float brightness = dot(tex_col, vec3(0.299, 0.587, 0.114));

    // координаты пикселя в сетке
    vec2 pixel_coord = UV * grid_size + TIME*0.1;
    vec2 cell = floor(pixel_coord);
    vec2 cell_uv = fract(pixel_coord) - 0.5;

    float radius = max_radius * (1.0 - brightness);
    float dist = length(cell_uv);

    float mask = smoothstep(radius, radius - 0.02, dist);

    // используем исходный цвет текстуры для halftone
    vec3 halftone_col = mix(tex_col, color_dot.rgb, mask);

    // смешиваем с оригинальной текстурой по dither_strength
    ALBEDO = mix(tex_col, halftone_col, dither_strength);
}
