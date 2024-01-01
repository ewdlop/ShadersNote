void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord-.5*iResolution.xy)/iResolution.y;
    vec3 col = vec3(0);

    // Adjust the frequency and phase of the sine and cosine functions
    float frequency = 2.;
    float time = iTime; // Assuming iTime is a uniform representing elapsed time

    for(int i = 0; i < 10; i++)
    {
        float t = float(i) * 0.001 + time * 0.1; // Adjust t for a smooth curve and animate it
        float y = cos(3. * frequency * 3.1415 * t) * 0.5; // Scale and translate y
        float x = sin(2. * frequency * 3.1415 * t) * 0.5; // Scale and translate x

        // Check if the pixel is close to the point on the curve
        if (length(uv - vec2(x,y)) < 0.01) {
            col += vec3(1,0,0); // Incrementally color it red
        }
    }
    
    for(int i = 0; i < 1000; i++)
    {
        float t = float(i) * 0.001; // Adjust t for a smooth curve and animate it
        float y = cos(3. * frequency * 3.1415 * t) * 0.5; // Scale and translate y
        float x = sin(2. * frequency * 3.1415 * t) * 0.5; // Scale and translate x

        // Check if the pixel is close to the point on the curve
        if (length(uv - vec2(x,y)) < 0.01) {
            col += vec3(0,abs(uv.x),abs(uv.y)); // Incrementally color
        }
   }

    col = clamp(col, 0.0, 1.0); // Ensure color components are within valid range

    fragColor = vec4(col,1.0); // Set the color of the pixel
}
