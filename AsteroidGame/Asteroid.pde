class Asteroid extends Entity {
  private PShape shape;
  private float radius;
  
  Asteroid() {
    super();
  }

  Asteroid(float px, float py, float raio) {
    this();
    pos.x = px;
    pos.y = py;
    shape = generateShape(raio);
  }
  
  void randomProperties(){
    speed = random(-2, 2);
    angle = random(180, 360);
  }

  void draw() {
    if(!active || shape == null) return;
    move();
    shape(shape, pos.x, pos.y);
  }
  
  public void generate(float x, float y, float radius){
    pos.x = x;
    pos.y = y;
    this.radius = radius;
    randomProperties();
    shape = generateShape(radius);
  }
  
  PShape generateShape(float radius) {
    int numPoints = int(random(8, 16));
    PShape s = createShape();
    s.beginShape();
    s.noFill();
    s.stroke(255);
    for (int i = 0; i < numPoints; i++) {
      float ang = TWO_PI / numPoints * i;
      float r = radius * random(0.6, 1.2);
      float vx = cos(ang) * r;
      float vy = sin(ang) * r;
      s.vertex(vx, vy);
    }
    s.endShape(CLOSE);
    active = true;
    return s;
  }
  
  float getRadius(){
    return radius;
  }

}
