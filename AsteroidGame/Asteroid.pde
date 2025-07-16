class Asteroid extends Entity {
  private PShape shape;
  private float radius;
  private boolean active;
  
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
  
  boolean pointInsideShape(float px, float py) {
    int count = shape.getVertexCount();
    int crossing = 0;
    
    for (int i = 0; i < count; i++) {
      PVector v1 = shape.getVertex(i);
      PVector v2 = shape.getVertex((i + 1) % count);
  
      float x1 = v1.x + pos.x;
      float y1 = v1.y + pos.y;
      float x2 = v2.x + pos.x;
      float y2 = v2.y + pos.y;
  
      if ((y1 > py) != (y2 > py)) {
        float interX = (x2 - x1) * (py - y1) / (y2 - y1) + x1;
        if (px < interX) crossing++;
      }
    }
    return crossing % 2 == 1;
  }
  
  float getRadius(){
    return radius;
  }

}
