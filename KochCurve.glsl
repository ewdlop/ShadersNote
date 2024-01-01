vec2 N(float angle) {
    return vec2(sin(angle), cos(angle));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord-.5*iResolution.xy)/iResolution.y;
	vec2 mouse = iMouse.xy/iResolution.xy; // 0 1 
    uv *= 1.25;
    
    uv.x = abs(uv.x);
    
    vec3 col = vec3(0);
    float d;
    
    float angle = 0.;
    vec2 n = N((5./6.)*3.1415);
    
    uv.y += tan((5./6.)*3.1415)*.5;
   	d = dot(uv-vec2(.5, 0), n);
    uv -= max(0.,d)*n*2.;
    
    float scale = 1.;
    
    n = N(mouse.y*(2./3.)*3.1415);
    uv.x += .5;
    for(int i=0; i<5; i++) {
        uv *= 3.;
        scale *= 3.;
        uv.x -= 1.5;
        
        uv.x = abs(uv.x);
        uv.x -= .5;
        
        d = dot(uv, n);
        uv -= min(0.,d)*n*2.;
    }
    
    d = length(uv - vec2(clamp(uv.x,-1., 1.), 0));
    col += smoothstep(1./iResolution.y, .0, d/scale);
    uv /= scale;	// normalization
    
    col.r += texture(iChannel0, uv*2.-iTime*.03).r;    
    col.g += texture(iChannel1, uv*2.-iTime*.03).g;
    col.b += texture(iChannel2, uv*2.-iTime*.03).b;


    
    fragColor = vec4(col,1.0);
}