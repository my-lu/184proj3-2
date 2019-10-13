import THREE from '../lib/three';
import Renderer from '../lib/renderer';
import vert from '../shaders/extra/test.vert';
import frag from '../shaders/task-2/phong.frag';

import texture from '../textures/displacement2.png';

class T5Renderer extends Renderer {
  initScene() {
    if (!this.checkShader(vert, frag)) {
      this.setErrorScene();
      return;
    }

    this.setLight();

    const textureDisplacement = new THREE.TextureLoader().load(texture);
    this.uniforms['textureDisplacement'] = {
      type: "t",
      value: textureDisplacement
    };
    this.uniforms['textureDimension'] = {
      type: 'vec2',
      value: new THREE.Vector2(100.0, 100.0)
    };

    const geometry = new THREE.SphereBufferGeometry(5, 1024, 1024);
    geometry.computeTangents();
    const material = this.createShaderMaterial(vert, frag);

    const object = new THREE.Mesh(geometry, material);
    this.scene.add(object);
  }

  update(dt) {
    if (!this.focussed) {
      this.updateCamera(dt / 12000);
    }
  }
}

export default T5Renderer;