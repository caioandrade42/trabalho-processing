class BulletsBuffer extends Buffer<Bullet>{
  private float lastShot;
  
  BulletsBuffer(int capacity){
    super(Bullet.class, capacity, Bullet::new);
  }

  boolean generateBullet(float x, float y, float angle) {
    if(millis() - lastShot < 300) return false;
    lastShot = millis();
    for (int i = 0; i < buffer.length; i++) {
      if(!buffer[i].active) {
        buffer[i].generate(x, y, angle);
        return true;
      }
    }
    return false;
  }
}
