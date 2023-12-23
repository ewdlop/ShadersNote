float Circle(vec2 p, vec2 c)
{
    float d = length(p-c);
    return smoothstep(fwidth(d),0.,d-.02);
}

float Line(vec2 p, vec2 a, vec2 b)
{
    vec2 pa = p-a;
    vec2 ba = b-a;
    float t = clamp(dot(pa, ba)/dot(ba,ba),0.,1.);
    vec2 c = a + ba*t;
    float d = length(c-p);
    return smoothstep(fwidth(d),0.,d-.001);
}

vec2 Bezier(vec2 a, vec2 b,vec2 c, float t){
    return mix(mix(a,c,t), mix(c,b,t),t);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = (fragCoord-.5*iResolution.xy)/iResolution.y;

    // Time varying pixel color
    vec3 col = vec3(0);

    float t= sin(iTime)*.5+.5;
    
    vec2 A = vec2(-.4,-.2);
    vec2 B = vec2(.4,.2);
    vec2 C = (iMouse.xy-.5*iResolution.xy)/iResolution.y;
    vec2 AC = mix(A,C,t);
    vec2 CB = mix(C,B,t);
    vec2 ACB = mix(AC,CB,t);
    
    col+=vec3(1,0,0)*Circle(uv, A);
    col+=vec3(0,1,0)*Circle(uv, B);
    col+=vec3(1,0,1)*Circle(uv, C);
    
    col+=vec3(1,1,0)*Circle(uv,AC);
    col+=vec3(0,1,1)*Circle(uv,CB);
    col+=vec3(1,1,1)*Circle(uv,ACB);
    
    col+= Line(uv,A,C) + Line(uv, C,B);   
    col+= Line(uv,AC, CB);
    
    int NUM_SEGS = 25;
    vec2 P, PP=A;
    for(int i=1; i<=NUM_SEGS;i++){
        t = float(i)/float(NUM_SEGS);
        P = Bezier(A,B,C,t);
        col += max(col,Line(uv,P,PP));
        PP = P;
    }
    
    // Output to screen
    fragColor = vec4(col,1.0);
}