void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy; //Normalize vector  0 <> 1
    
    uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;
    
    float d = length(uv);
    float r = 0.4;
    
    float c = smoothstep(r, r - 0.1, d);
    
    //if (d < 0.4) c = 1.0; else c = 0.0;
    
    fragColor = vec4(vec3(c), 1.0);
}