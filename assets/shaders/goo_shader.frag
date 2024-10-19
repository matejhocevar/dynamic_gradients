#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 uResolution;
uniform sampler2D uTex;

const float blurSize = 10.0;
const float blurStrength = 0.004;
const vec4 offset = vec4(0, 0, 0, -8.0);

out vec4 oColor;

void main() {
    vec2 uv = vec2(FlutterFragCoord().xy) / uResolution;

    vec4 color = vec4(0.0);
    float totalWeight = 0.0;

    // Apply Gaussian Blur
    for (float x = -blurSize; x <= blurSize; x++) {
        for (float y = -blurSize; y <= blurSize; y++) {
            float d = length(vec2(x, y));
            float weight = exp(-0.5 * pow(d / blurSize, 2.0)) / (sqrt(2.0 * 3.14159265) * blurSize);
            color += texture(uTex, uv + vec2(x, y) * blurStrength) * weight;
            totalWeight += weight;
        }
    }
    color /= totalWeight;

    // Apply Color Matrix
    vec4 result;
    result.r = color.r * 1.0 + color.g * 0.0 + color.b * 0.0 + color.a * 0.0;
    result.g = color.r * 0.0 + color.g * 1.0 + color.b * 0.0 + color.a * 0.0;
    result.b = color.r * 0.0 + color.g * 0.0 + color.b * 1.0 + color.a * 0.0;
    result.a = color.r * 0.0 + color.g * 0.0 + color.b * 0.0 + color.a * 11;

    oColor = result + offset;
}