# SPIR-V Cross 

![2024-spirv-language-ecosystem.jpg](https://www.khronos.org/assets/uploads/apis/2024-spirv-language-ecosystem.jpg)

To convert a **Cg shader** to **GLSL** using **SPIR-V Cross**, you would typically follow these steps:

### **Steps to Convert Cg Shader to GLSL using SPIR-V Cross**
1. **Compile Cg shader to SPIR-V bytecode** using `glslangValidator` or another tool.
2. **Use SPIR-V Cross** to convert SPIR-V to GLSL.

---

### **Command-line Workflow**
1. **Compile Cg shader (assuming you have a `.cg` or `.vert/.frag` file)**:
   ```sh
   glslangValidator -V shader.cg -o shader.spv
   ```
   *(Make sure to install `glslangValidator` if you don't have it.)*

2. **Use SPIR-V Cross to convert it into GLSL:**
   ```sh
   spirv-cross shader.spv --version 300 --output shader.glsl
   ```
   This converts the SPIR-V to a GLSL-compatible shader file.

---

### **Example of Converted GLSL**
Here’s an example of what a **converted Cg shader** might look like after using `SPIR-V Cross`:

```glsl
#version 300 es
precision highp float;

in vec2 vUv;
out vec4 fragColor;

uniform float time;

void main() {
    float dist = length(vUv - vec2(0.5));
    float blackHole = smoothstep(0.3, 0.32, dist);
    float glow = smoothstep(0.3, 0.5, dist);
    vec3 color = mix(vec3(0.0), vec3(1.0, 0.5, 0.2), glow);
    color *= (1.0 - blackHole);
    fragColor = vec4(color, 1.0);
}
```
---
### **Integration into Your WebGL Code**
After converting your Cg shader, you can integrate it into the WebGL script:

1. **Replace `fragmentShaderSource` with the newly generated GLSL code**.
2. **Ensure compatibility** with WebGL 2.0 by using `#version 300 es` and changing `gl_FragColor` to `fragColor`.

---
### **Final Thoughts**
- If your shader was more complex (e.g., with Cg-specific functions), `SPIR-V Cross` handles conversion automatically.
- If any errors occur in WebGL, check `console.error(gl.getShaderInfoLog(shader));` to debug.

Would you like me to integrate this GLSL into your existing WebGL code? 🚀
