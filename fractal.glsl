void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = (fragCoord - .5*iResolution.xy)/iResolution.xy;
    vec2 mouse = iMouse.xy/iResolution.xy;

    // Time varying pixel color
    vec3 col = vec3(0);
    
    float angle = (2./3.)*mouse.x * 3.1415;
    float scale = 1.;
    vec2 n = vec2(sin(angle), cos(angle));
    
    //float d = dot(uv,n);
    //col+= smoothstep(.01, .0, abs(d));

    

    
    uv.x +=.5;
    for(int i=0; i<10; i++) {
            uv *= 3.;
            scale *= 3.;
            uv.x -= 1.5;

            uv.x = abs(uv.x);
            uv.x -= .5;
            uv -= min(0.,dot(uv,n))*n*2.; //reflection
        }
    
        float d = length(uv - vec2(clamp(uv.x, -.1,.1),0));
    col+=smoothstep(1./iResolution.y, .0,d/scale);
    // Output to screen
    fragColor = vec4(col,1.0);
}