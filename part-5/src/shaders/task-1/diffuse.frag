precision highp float;

uniform vec3 lPosition;
uniform vec3 lIntensity;

varying vec3 fPosition;
varying vec3 fNormal;

void main() {
    // TODO: Part 5.1
    float l = length(fPosition - lPosition);
    gl_FragColor = vec4(lIntensity / (l * l) * max(0.0, dot(fNormal, normalize(lPosition))), 1.0);
}