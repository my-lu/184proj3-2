#define M_PI 3.1415926535897932384626433832795

attribute vec3 position;
attribute vec3 normal;
attribute vec3 tangent;
attribute vec2 uv;

uniform mat4 modelMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform sampler2D textureDisplacement;
uniform vec2 textureDimension;
uniform float time;

varying vec3 fPosition;
varying vec3 fNormal;
varying vec2 fUv;

void main() {
    vec3 offset = position;
    float t = time / 1000.;
    
    mat3 tbn;
    tbn[0] = tangent;
    tbn[1] = cross(normal, tangent);
    tbn[2] = normal;

    // TODO: Compute displaced vertices
    float heightScaling = 0.6;

    // TODO: Compute displaced normals
    float normalScaling = 1.0;

    float w = textureDimension.x;
    float h = textureDimension.y;
    float du = (texture2D(textureDisplacement, vec2(uv.x + 1.0 / w, uv.y)) - texture2D(textureDisplacement, vec2(uv.x, uv.y))).r * heightScaling * normalScaling;
    float dv = (texture2D(textureDisplacement, vec2(uv.x, uv.y + 1.0 / h)) - texture2D(textureDisplacement, vec2(uv.x, uv.y))).r * heightScaling * normalScaling;

    offset = offset + texture2D(textureDisplacement, vec2(uv.x, uv.y)).r * heightScaling * normal;

    offset += normal * (0.5 * sin(t * 2. * M_PI) * sin(uv.x * 8. * M_PI) + 0.5);
    offset += normal * (0.5 * cos(t * uv.y * M_PI) + 0.5);

    fUv = uv;


	fPosition = vec3(modelMatrix * vec4(offset, 1.0));
    fNormal = vec3(modelMatrix * vec4(tbn * vec3(-du, -dv, 1.0), 0.0));
    gl_Position = projectionMatrix * modelViewMatrix * vec4(offset, 1.0);
}