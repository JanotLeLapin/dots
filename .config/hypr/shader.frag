precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

const float temperature = 2.5;

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);

    // pixColor[0] *= (temperature <= 66 ? 1 : (temperature - 60) / 329.698);
    pixColor[1] *= 0.4;
    pixColor[2] *= 0.1;

    gl_FragColor = pixColor;
}
