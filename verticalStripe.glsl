void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from -0.5 to 0.5)
    vec2 uv = (fragCoord -.5*iResolution.xy)/iResolution.y;
    uv *= 3;
    
    vec3 col = vec3(0);

    float d = length(uv);
    float m = .02/d;
    
    m = abs(uv.x);
    col += m;
    
    
    // Output to screen
    fragColor = vec4(col,1.0);
}