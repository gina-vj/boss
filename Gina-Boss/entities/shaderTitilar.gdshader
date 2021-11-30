shader_type canvas_item;

uniform bool active=false;

void fragment()
{vec4 color_origin=texture(TEXTURE,UV);
	vec4 color=vec4(1.0,1.0,1.0,1.0);
	vec4 color_final=color_origin*color;
	if(active){
	
	color_final*=mod(TIME,1.5);
	COLOR=color_final;
	}
	else{
		COLOR=color_final;
	}
	
	
}