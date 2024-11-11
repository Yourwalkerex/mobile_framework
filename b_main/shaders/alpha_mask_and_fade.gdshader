shader_type canvas_item;

const float EPSILON = 0.01;

uniform vec4 alpha : source_color = vec4(0,0,0,0);
uniform vec4 alpha_mask : source_color = vec4(0,0.79,0.79,1);
uniform vec4 fade_mask : source_color = vec4(1,0,1,1);
uniform bool fading = false;


bool is_approx(vec4 col_a, vec4 col_b){
  return length(abs(col_a - col_b)) < EPSILON;}


void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	if(is_approx(tex_color,alpha_mask)){
		tex_color = alpha;}
	if(fading){
		if(is_approx(tex_color,fade_mask)){
			tex_color = alpha;}}
	COLOR = tex_color;}