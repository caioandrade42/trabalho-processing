class ExpandEffect implements ParticleEffect {
  public void apply(Particle particle, float progress) {
    particle.size = particle.baseSize * (1 + progress);
  }
}

class FadeEffect implements ParticleEffect {
  public void apply(Particle particle, float progress) {
    particle.alpha = 255 * (1 - progress);
  }
}
