mat2 Rot(float a) {
    float s = sin(a), c = cos(a);
    return mat2(c, -s, s, c);
}

float Star(vec2 uv, float flare){
    float d = length(uv);
    float m = .05/d;
    
    
    float rays = max(0.,1.-abs(uv.x * uv.y * 1000.));
    m += rays* flare;
    uv *= Rot(3.1415/4.);
    rays = max(0.,1.-abs(uv.x * uv.y * 1000.));
    m += rays * .3 * flare;
    m*= smoothstep(1.,.2,d);
    return m;
}

//RNG
float Hash21(vec2 p){
    p = fract(p*vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from -0.5 to 0.5)
    vec2 uv = (fragCoord -.5*iResolution.xy)/iResolution.y;
    uv *= 5.;
    
    vec3 col = vec3(0);

    //boxes
    vec2 gv = fract(uv) - 0.5;
    vec2 id = floor(uv);
    
    for(int y=-1;y<=1;y++){
        for(int x=-1;x<=1;x++){
            vec2 offs = vec2(x,y);
            float n=  Hash21(id+offs); // random betwen 0 and 1
            float size = fract(n*345.32);
            float star = Star(gv-offs-vec2(n,fract(n*34.))+.5,smoothstep(.8, .9, size));
            vec3 color = sin(vec3(.2,.3,.9)*fract(n*2345.2)*6.2831)* 0.5 + 0.5;
            color = color* vec3(1,.5,1.+size);
            col += size * star * color;
        }
    }

    
    //red grid
    //if(gv.x > .48 || gv.y > .48) col.r = 1.;
    
    //col.rg += id*.4;
    //col += Hash21(uv);
    
    // Output to screen
    fragColor = vec4(col,1.0);
}