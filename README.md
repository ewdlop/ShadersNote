# Shaders Note
<img width="598" alt="image" src="https://github.com/ewdlop/ShadersNote/assets/25368970/9163e003-a3b2-4dfa-ad91-e2e696fef814"/>

Source: https://www.youtube.com/watch?v=dhuigO4A7RY&t=1246s

Demo: https://www.shadertoy.com/view/lcsGW7

<img width="601" alt="BezierCurve" src="https://github.com/ewdlop/ShadersNote/assets/25368970/f636d48a-13fa-42c7-a277-6965bc88cb24">

Source: https://www.youtube.com/watch?v=a4zMX6dDVXI

Demo: https://www.shadertoy.com/view/Xfs3RX

## Shader Descriptions

### BezierCurve.glsl
Contains functions for drawing circles, lines, and Bezier curves, including cubic Bezier curves. The `mainImage` function uses these to create a dynamic image.

Source: [BezierCurve.glsl](BezierCurve.glsl)

### fractal.glsl
Generates a fractal pattern using a series of transformations and reflections, with color based on distance from a central point.

Source: [fractal.glsl](fractal.glsl)

### grid.glsl
Creates a grid pattern with stars at the intersections, using a rotation matrix and a star function.

Source: [grid.glsl](grid.glsl)

### KochCurve.glsl
Generates a Koch curve fractal pattern, with color based on distance from the curve and textures applied.

Source: [KochCurve.glsl](KochCurve.glsl)

### light.glsl
Creates a light effect with a central bright spot that fades outwards.

Source: [light.glsl](light.glsl)

### parametric-curve.vs
Generates a parametric curve using sine and cosine functions, with color based on proximity to the curve.

Source: [parametric-curve.vs](parametric-curve.vs)

### shaderToySample.glsl
Generates a dynamic color pattern based on time and pixel coordinates.

Source: [shaderToySample.glsl](shaderToySample.glsl)

### star.glsl
Creates a star pattern with rays and a central bright spot, using a rotation matrix.

Source: [star.glsl](star.glsl)

### starGridRandomPosition.glsl
Generates a grid of stars with random positions and sizes, using a hash function for randomness.

Source: [starGridRandomPosition.glsl](starGridRandomPosition.glsl)

### starGridWithNoise.glsl
Creates a grid of stars with added noise for randomness, using a hash function.

Source: [starGridWithNoise.glsl](starGridWithNoise.glsl)

### starRandomPositionRandomColor.vs
Generates stars with random positions, sizes, and colors, using a hash function for randomness.

Source: [starRandomPositionRandomColor.vs](starRandomPositionRandomColor.vs)

### stars.glsl
Creates a layered star field with depth and parallax effects, using a hash function for randomness and a rotation matrix.

Source: [stars.glsl](stars.glsl)

### verticalStripe.glsl
Generates a vertical stripe pattern with color based on the x-coordinate.

Source: [verticalStripe.glsl](verticalStripe.glsl)
