/*
Shader from Godot Shaders - the free shader library.
godotshaders.com/shader/teleport-effect

This shader is under CC0 license. Feel free to use, improve and 
change this shader according to your needs and consider sharing 
the modified result on godotshaders.com.
*/

shader_type canvas_item;


uniform float flash_modifier:hint_range(0.0,1.0);
uniform vec4  flash_color :hint_color= vec4(1.0);


// We are generating our own noise here. You could experiment with the 
// built in SimplexNoise or your own noise texture for other effects.


void fragment()
{
	vec4 color = texture(TEXTURE, UV);
	color.rgb=mix(color.rgb,flash_color.rgb,flash_modifier);
	
	
	COLOR = color;
}