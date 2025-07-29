import java.util.List;

class Particle extends Entity {
  float size;
  float baseSize;
  float spawnTime;
  float lifeTime;
  PImage particleImage;
  boolean spawned;
  List<ParticleEffect> effects = new ArrayList<>();
  float alpha = 255;

  void draw() {
    active = millis() - spawnTime < lifeTime;

    if (spawned) {
      if (active) {
        float progress = (millis() - spawnTime) / lifeTime;

        for (ParticleEffect effect : effects) {
          effect.apply(this, progress);
        }

        move();
        wrapPosition();

        tint(255, alpha);
        image(particleImage, pos.x, pos.y, size, size);
        noTint();
      } else {
        spawned = false;
      }
    }
  }

  void setImage(PImage img) {
    this.particleImage = img;
  }

  void generate(float x, float y, float size, float lifeTime, float speed, float angle, List<ParticleEffect> effects) {
    this.pos.x = x;
    this.pos.y = y;
    this.baseSize = size;
    this.size = size;
    this.lifeTime = lifeTime;
    this.spawnTime = millis();
    this.active = true;
    this.spawned = true;
    this.effects.clear();
    this.effects.addAll(effects);
    this.alpha = 255;
    this.speed = speed;
    this.angle = angle;
  }

}
