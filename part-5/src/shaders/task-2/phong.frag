precision highp float;

uniform vec3 cameraPosition;
uniform vec3 lPosition;
uniform vec3 lIntensity;

varying vec3 fPosition;
varying vec3 fNormal;

void main() {
    // TODO: Part 5.2
    float l = length(fPosition - lPosition);
    vec3 h = normalize(((lPosition - fPosition) + (cameraPosition - fPosition)) / 2.0);
    gl_FragColor = 0.1 * vec4(1.0) + 0.8 * vec4(lIntensity / (l * l) * max(0.0, dot(fNormal, normalize(lPosition))), 1.0) + 0.5 * vec4(lIntensity / (l * l) * pow(max(0.0, dot(fNormal, h)), 100.0), 1.0);
}