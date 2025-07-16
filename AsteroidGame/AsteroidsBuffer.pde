class AsteroidsBuffer{
  private static final int MAX_CAPACITY = 50;
  private final Asteroid[] buffer = new Asteroid[MAX_CAPACITY];
  
  AsteroidsBuffer(){
    for(int i = 0; i < MAX_CAPACITY; i++){
      buffer[i] = new Asteroid();
    }
  }
  
  void generateAsteroid(float radius) {
    float x = random(0, width);
    float y = random(0, height);
    generateAsteroid(x, y, radius);
  }
  
  void generateAsteroid(float x, float y, float radius) {
    for (int i = 0; i < buffer.length; i++) {
      if(!buffer[i].ativo) {
        buffer[i].generate(x, y, radius);
        return;
      }
    }
  }
  
  void draw(){
    for(Asteroid asteroid : buffer){
      asteroid.draw();
    }
  }
  
  Asteroid[] getBuffer(){
    return buffer;
  }
}
