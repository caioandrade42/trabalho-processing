class Spaceship extends Entity {
  
  PShape shipShape;
  PVector[] transformedVerts;
  ParticleSystem smoke = new ParticleSystem(10, "./sprites/smoke.png", 50);
  ParticleSystem explosion = new ParticleSystem(10, "./sprites/smoke.png", 0);
  
  Spaceship() {
    super();
    pos.x = width / 2;
    pos.y = height / 2;
    acc = new PVector();
    angle = -HALF_PI;
    active = true;
    
    shipShape = createShape();
    shipShape.beginShape();
    shipShape.noFill();
    shipShape.stroke(255);
    shipShape.vertex(-10, -10);
    shipShape.vertex(10, 0);
    shipShape.vertex(-10, 10);
    shipShape.vertex(-5, 0);
    shipShape.endShape(CLOSE);
    transformedVerts = new PVector[shipShape.getVertexCount()];
    for(int i = 0; i < transformedVerts.length; i++){
      transformedVerts[i] = new PVector();
    }
  }

  void draw() {
    pos.add(acc);
    wrapPosition();
    updateTransformedVertices();
    if(active){
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(angle);
      shape(shipShape);
      popMatrix();
    }
    speed = max(0, speed - 0.28);
    acc.mult(0.998);
    smoke.draw();
    explosion.draw();
  }

  void control() {
    if (KeyboardListener.checkKey(RIGHT)) angle += 0.05;
    if (KeyboardListener.checkKey(LEFT))  angle -= 0.05;

    if (KeyboardListener.checkKey(UP)){
      speed = min(6, speed + 0.050);
      acc.x += cos(angle) * speed;
      acc.y += sin(angle) * speed;
      float limitSpeed = 2.8;
      acc.x = limitValue(acc.x, -limitSpeed, limitSpeed);
      acc.y = limitValue(acc.y, -limitSpeed, limitSpeed);
      
      float backAngle = angle + PI;
      float tailOffset = 12;
      
      float spawnX = pos.x + cos(backAngle) * tailOffset;
      float spawnY = pos.y + sin(backAngle) * tailOffset;
      smoke.generateParticle(
          spawnX, spawnY, 10, 500, 2, backAngle,
        List.of(new ExpandEffect(), new FadeEffect())
      );
    }
  }
  
  float limitValue(float value, float minimum, float maximum){
    return min(max(value, minimum), maximum);
  }
  
  void updateTransformedVertices() {
    for (int i = 0; i < transformedVerts.length; i++) {
      PVector v = shipShape.getVertex(i);
  
      float x = v.x * cos(angle) - v.y * sin(angle);
      float y = v.x * sin(angle) + v.y * cos(angle);
  
      transformedVerts[i].set(x + pos.x, y + pos.y);
    }
  }
  
  void explode(){
    active = false;
  
    for(int i = 0; i < 10; i++){
      float explosionX = pos.x + random(-15, 15);
      float explosionY = pos.y + random(-15, 15);
      float explosionTime = random(500, 3700);
      float startSize = random(15, 30);
      explosion.generateParticle(
            explosionX, explosionY, startSize, explosionTime, 0, 0,
          List.of(new ExpandEffect(), new FadeEffect())
        );
    }
  }
  
  void reset(){
    active = true;
    pos.x = width/2;
    pos.y = height/2;
    acc.x = 0;
    acc.y = 0;
    speed = 0;
    angle = -HALF_PI;
  }

}
