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

// Cubic Bezier Function using mix
vec2 CubicBezier(vec2 P0, vec2 P1, vec2 P2, vec2 P3, float t) {
    float u = 1.0 - t;
    // Linearly interpolate between points
    vec2 A = mix(P0, P1, t); // point between P0 and P1
    vec2 B = mix(P1, P2, t); // point between P1 and P2
    vec2 C = mix(P2, P3, t); // point between P2 and P3

    // Now interpolate between A, B, and C to find the curve point
    vec2 D = mix(A, B, t); // point between A (P0-P1) and B (P1-P2)
    vec2 E = mix(B, C, t); // point between B (P1-P2) and C (P2-P3)

    // Finally, interpolate between D and E to get the point on the curve
    vec2 curvePoint = mix(D, E, t); // Cubic Bezier Curve point

    return curvePoint;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = (fragCoord-.5*iResolution.xy)/iResolution.y;

    // Time varying pixel color
    vec3 col = vec3(0);

    float t= sin(iTime)*.5+.5;
    
    vec2 A = vec2(-.8,-.4);
    vec2 B = vec2(.8,.4);
    vec2 C = (iMouse.xy-.5*iResolution.xy)/iResolution.y; //control point 1
    vec2 D = C+ vec2(.1,.1); // control point 2
    vec2 AC = mix(A,C,t);
    vec2 CB = mix(C,B,t);
    vec2 CD = mix(C,D,t);
    vec2 ACB = mix(AC,CB,t);
    vec2 AD = mix(A,D,t);
    vec2 DB = mix(D,B,t);
    vec2 ADB = mix(AD,DB,t);

    vec2 ACD = mix(AC,CD,t);
    vec2 CDB = mix(CD,DB,t);
    vec2 ACDB = mix(ACD,CDB,t);
    
    
    col+=vec3(1,0,0)*Circle(uv, A);
    col+=vec3(0,1,0)*Circle(uv, B);
    col+=vec3(1,0,1)*Circle(uv, C);    
    col+=vec3(.5,.5,.5)*Circle(uv, D);

    
    col+=vec3(1,1,0)*Circle(uv,AC);
    col+=vec3(0,1,1)*Circle(uv,CB);    
    col+=vec3(0,1,1)*Circle(uv,CD);
    col+=vec3(1,1,1)*Circle(uv,ACB);
    
    col+=vec3(1.,1.,.5)*Circle(uv,AD);
    col+=vec3(.5,1.,1.)*Circle(uv,DB);
    col+=vec3(0.5,1.,1.)*Circle(uv,ADB);
    col+=vec3(1.,.5,1.)*Circle(uv,ACD);
    col+=vec3(1.,.5,1.)*Circle(uv,CDB);
    col+=vec3(1.,.5,1.)*Circle(uv,ACDB);
    
    col+= Line(uv,A,C) + Line(uv, C,B);   
    col+= Line(uv,AC, CB);
    
    col+= Line(uv,A,D) + Line(uv, D,B);   
    col+= Line(uv,AD, DB);
    
    col+= Line(uv,A,C) + Line(uv, C,DB);   
    col+= Line(uv,AC, CD);
    
    col+= Line(uv,C,D) + Line(uv, D,B);   
    col+= Line(uv,CD, DB);
    
    int NUM_SEGS = 25;
    vec2 P, PP=A;
    for(int i=1; i<=NUM_SEGS;i++){
        t = float(i)/float(NUM_SEGS);
        P = CubicBezier(A,C,D,B,t);
        col += max(col,Line(uv,P,PP));
        PP = P;
    }
    
    NUM_SEGS = 25;
    P=A;
    PP=A;
    for(int i=1; i<=NUM_SEGS;i++){
        t = float(i)/float(NUM_SEGS);
        P = Bezier(A,B,C,t);
        col += max(col,Line(uv,P,PP));
        PP = P;
    }
    
        NUM_SEGS = 25;
    P=A;
    PP=A;
    for(int i=1; i<=NUM_SEGS;i++){
        t = float(i)/float(NUM_SEGS);
        P = Bezier(A,B,D,t);
        col += max(col,Line(uv,P,PP));
        PP = P;
    }
    
    
    
    // Output to screen
    fragColor = vec4(col,1.0);
}