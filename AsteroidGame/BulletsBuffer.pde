class BulletsBuffer{
  private final int MAX_CAPACITY = 10;
  private final Bullet[] buffer = new Bullet[MAX_CAPACITY];
  private float lastShot;
  
  BulletsBuffer(){
    for(int i = 0; i < MAX_CAPACITY; i++){
      buffer[i] = new Bullet();
    }
  }
  
  void generateBullet(float x, float y, float angle) {
    if(millis() - lastShot < 300) return;
    lastShot = millis();
    for (int i = 0; i < buffer.length; i++) {
      if(!buffer[i].active) {
        buffer[i].generate(x, y, angle);
        return;
      }
    }
  }
  
  void draw(){
    for(Bullet bullet : buffer){
      bullet.draw();
    }
  }
  
  Bullet[] getBuffer(){
    return buffer;
  }
  
}
