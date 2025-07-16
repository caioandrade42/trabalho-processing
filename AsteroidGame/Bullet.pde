class Bullet extends Entity{
  
  private boolean active;
  private static final int BULLET_SIZE = 3;
  private float timeShot;

  Bullet(){
    super();
    speed = 5;
  }
  
  Bullet(float x, float y, float angle){
    this();
    pos.x = x;
    pos.y = y;
    this.angle = angle;
  }
  
  public void draw(){
    if(millis() - timeShot > 2000) active = false;
    if(!active) return;
    move();
    fill(255);
    circle(pos.x, pos.y, BULLET_SIZE);
  }
  
  public void generate(float x, float y, float angle){
    pos.x = x;
    pos.y = y;
    this.angle = angle;
    active = true;
    timeShot = millis();
  }
}
