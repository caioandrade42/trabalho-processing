class AsteroidsBuffer extends Buffer<Asteroid>{
  
  AsteroidsBuffer(int capacity){
    super(Asteroid.class, capacity, Asteroid::new);
  }
  
  void generateAsteroid(float x, float y, float radius) {
    for (int i = 0; i < buffer.length; i++) {
      if(!buffer[i].active) {
        buffer[i].generate(x, y, radius);
        return;
      }
    }
  }
}
