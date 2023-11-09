float Circle(vec2 uv, vec2 position, float radius, float blur) {
    float distance = length(uv - position);
    float c = smoothstep(radius, radius - blur, distance);
    
    return c;
}


void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy; //Normalize vector  0 <> 1
    
    uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;
    
    vec3 color = vec3(0.0, 0.0,0.0);
    
    float mask = Circle(uv, vec2(0.0, 0.0), 0.4, 0.05);
    
    mask -= Circle(uv, vec2(-0.125, 0.1), 0.075, 0.025);
    mask -= Circle(uv, vec2(0.125, 0.1), 0.075, 0.025);
    
    float mouth = Circle(uv, vec2(0.0, 0.0), 0.3, 0.025);
    mouth -= Circle(uv, vec2(0.0, 0.1), 0.3, 0.025);
    
    
    mask -= mouth;
    color = vec3(1.0, 1.0, 0.0) * mask;
    //color = vec3(mouth);
    
    fragColor = vec4(vec3(color), 1.0);
}