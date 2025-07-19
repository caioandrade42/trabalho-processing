abstract class Entity{
  protected PVector pos;
  protected PVector acc;
  protected float speed;
  protected float angle;
  
  Entity(){
    pos = new PVector();
    acc = new PVector();
  }
  
  abstract void draw();
  
  void move(){
    acc.x = cos(angle) * speed;
    acc.y = sin(angle) * speed;
    
    pos.add(acc);
    wrapPosition();
  }
  
  void wrapPosition(){
    if (pos.x > width) pos.x = 0;
    if (pos.x < 0) pos.x = width;
    if (pos.y > height) pos.y = 0;
    if (pos.y < 0) pos.y = height;
  }
  
  PVector getPosition(){
    return pos;
  }
  
  float getAngle(){
    return angle;
  }
}
