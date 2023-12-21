mat2 Rot(float a) {
    float s = sin(a), c = cos(a);
    return mat2(c, -s, s, c);
}
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from -0.5 to 0.5)
    vec2 uv = (fragCoord -.5*iResolution.xy)/iResolution.y;
    uv *= 3.;
    
    vec3 col = vec3(0);

    float d = length(uv);
    float m = .05/d;
    
    col += m;
    
    float rays = max(0.,1.-abs(uv.x * uv.y * 1000.));
    col += rays;
    
    uv *= Rot(3.1415/4.);
    
    rays = max(0.,1.-abs(uv.x * uv.y * 1000.));
    col += rays * .3;
    
    // Output to screen
    fragColor = vec4(col,1.0);
}