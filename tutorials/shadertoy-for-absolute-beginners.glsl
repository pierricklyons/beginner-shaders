float Circle(vec2 uv, vec2 position, float radius, float blur) {
    float distance = length(uv - position);
    float c = smoothstep(radius, radius - blur, distance);
    
    return c;
}

float Smiley(vec2 uv, vec2 position, float size) {
    uv -= position; // Translate coords
    uv /= size; // Scale coords
    
    float mask = Circle(uv, vec2(0.0, 0.0), 0.45, 0.05);
    mask -= Circle(uv, vec2(-0.125, 0.1), 0.075, 0.025);
    mask -= Circle(uv, vec2(0.125, 0.1), 0.075, 0.025);
    
    float mouth = Circle(uv, vec2(0.0, 0.0), 0.3, 0.025);
    mouth -= Circle(uv, vec2(0.0, 0.1), 0.3, 0.025);
    
    mask -= mouth;
    
    return mask;
}

float Band(float positionX, float start, float end, float blur) {
    float step1 = smoothstep(start - blur, start + blur, positionX);
    float step2 = smoothstep(end + blur, end - blur, positionX);
    return step1 * step2;
}

float Rectangle(vec2 uv, float left, float right, float top, float bottom, float blur) {
    float band1 = Band(uv.x, left, right, blur);
    float band2 = Band(uv.y, top, bottom, blur);
    
    return band1 * band2;
}

float remap01(float a, float b, float t) {
    return (t - a) / (b - a);
}

float remap(float a, float b, float c, float d, float t) {
     return remap01(a, b, t) * (d - c) + c;
}


void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy; //Normalize vector  0 <> 1
    float time = iTime;
    
    uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;
    
    vec3 color = vec3(0.0, 0.0,0.0);
    
    // float mask = Smiley(uv, vec2(0.0, 0.0), 2.0);
    
    float x = uv.x;
    
    float m = sin(time + x * 8.0) * 0.1;
    float y = uv.y - m;
    
    float blur = remap(-0.5, 0.5, 0.01, 0.25, x);
    blur = pow(blur * 4.0, 3.0);
    float mask = Rectangle(vec2(x, y), -0.5, 0.5, -0.1, 0.1, blur);
    
    color = vec3(1.0, 1.0, 1.0) * mask;
    //color = vec3(mouth);
    
    fragColor = vec4(vec3(color), 1.0);
}