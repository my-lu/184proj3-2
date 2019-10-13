attribute vec3 position;
attribute vec3 normal;
attribute vec3 tangent;
attribute vec2 uv;

uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 modelMatrix;
uniform sampler2D textureDisplacement;
uniform vec2 textureDimension;

varying vec3 fPosition;
varying vec3 fNormal;

void main() {
    vec3 offset = position;

    mat3 tbn;
    tbn[0] = tangent;
    tbn[1] = cross(normal, tangent);
    tbn[2] = normal;

    // TODO: Compute displaced vertices
    float heightScaling = 0.8;

    // TODO: Compute displaced normals
    float normalScaling = 1.0;

    float w = textureDimension.x;
    float h = textureDimension.y;
    float du = (texture2D(textureDisplacement, vec2(uv.x + 1.0 / w, uv.y)) - texture2D(textureDisplacement, vec2(uv.x, uv.y))).r * heightScaling * normalScaling;
    float dv = (texture2D(textureDisplacement, vec2(uv.x, uv.y + 1.0 / h)) - texture2D(textureDisplacement, vec2(uv.x, uv.y))).r * heightScaling * normalScaling;

    fPosition = vec3(modelMatrix * vec4(position, 1.0));
    fNormal = vec3(modelMatrix * vec4(tbn * vec3(-du, -dv, 1.0), 0.0));
    gl_Position = projectionMatrix * modelViewMatrix * vec4(offset, 1.0);
}