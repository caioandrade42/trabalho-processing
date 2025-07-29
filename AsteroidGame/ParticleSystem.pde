class ParticleSystem extends Buffer<Particle> {
  private final int spawnDelay;
  private int lastSpawn = 0;

  ParticleSystem(int capacity, String imagePath, int spawnDelay) {
    super(Particle.class, capacity, Particle::new);
    this.spawnDelay = spawnDelay;

    PImage image = loadImage(imagePath);

    for (Particle p : buffer) {
      p.setImage(image);
    }
  }

  void generateParticle(float x, float y, float size, float lifeTime, float speed, float angle, List<ParticleEffect> effects) {
    
    if (spawnDelay > 0 && millis() - lastSpawn < spawnDelay) return;
    
    lastSpawn = millis();

    for (int i = 0; i < buffer.length; i++) {
      if (!buffer[i].active) {
        buffer[i].generate(x, y, size, lifeTime, speed, angle, effects);
        return;
      }
    }
  }
}
